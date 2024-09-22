from pendulum import datetime

from airflow import DAG
from airflow.models import Variable
from airflow.operators.empty import EmptyOperator
from airflow.operators.bash import BashOperator 
from airflow.providers.databricks.operators.databricks import DatabricksSubmitRunOperator
from airflow.utils.task_group import TaskGroup
from cosmos import DbtDag, LoadMode, RenderConfig, DbtTaskGroup, ProfileConfig, ProjectConfig
from cosmos.profiles import DatabricksTokenProfileMapping
from cosmos.constants import TestBehavior
import logging
from pathlib import Path
import os


# get the airflow.task logger
task_logger = logging.getLogger("airflow.task")

DBT_PROJECT_NAME = Path(os.getenv("DBT_PROJECT_NAME", "lloyds_bank"))
DEFAULT_DBT_ROOT_PATH = Path(__file__).parent.parent / "dbt" / DBT_PROJECT_NAME
DBT_ROOT_PATH = Path(os.getenv("DBT_ROOT_PATH", DEFAULT_DBT_ROOT_PATH))
CLUSTER_ID = Variable.get("poc_cluster_id")
LND_SCHEMA = "LND" 

# get params
dag_var = Variable.get("dag_vars", deserialize_json=True)
src_tgt_map = dag_var["src_tgt_map"]
business_date = '{{ dag_run.conf["business_date"] }}' #dag_var["business_date"]
source_system =  dag_var["source_system"] #{{ dag_run.conf["source_system"] }}
batch_id = '{{ dag_run.conf["batch_id"] }}' #dag_var["batch_id"]

profile_config = ProfileConfig(
    profile_name="lloyds_bank_poc",
    target_name="dev",
    profile_mapping=DatabricksTokenProfileMapping(
        conn_id = 'adb_lb_conn'
    )
)

with DAG(
        dag_id="lloyds_bank_dbt",
        start_date=datetime(2023, 11, 8),
        schedule=None,
        concurrency=32,
        max_active_tasks=32
) as dag:
    task_logger.info(f"Starting {dag} execution")

    e1 = EmptyOperator(task_id="pre_dbt")

    # dbt_deps = BashOperator(
    #     task_id='dbt_deps',
    #     bash_command=f'cd "{DBT_ROOT_PATH}" && dbt deps',
    #     dag=dag
    # )

    task_logger.info(f"Starting landing ingestion")
    with TaskGroup(group_id='ingest_lnd_task_group') as tg1:
        for item in src_tgt_map:
            task_id = f'airflow_ingest_{item["tgt_table"]}'
            notebook_task = DatabricksSubmitRunOperator(
                task_id=task_id, 
                databricks_conn_id="adb_lb_conn",
                notebook_task={
                    "notebook_path": "/Shared/lloydsbank_poc/lnd/01_ingest_lnd_from_adls",
                    "base_parameters": {
                        "business_date": business_date,
                        "file_name": item["src_file_name_prefix"],
                        "source_system": source_system,
                        "table_name": f'{LND_SCHEMA}.{item["tgt_table"]}'
                    }
                },
                existing_cluster_id=CLUSTER_ID
            )

    task_logger.info("Starting dbt task execution")
    dag_var  = Variable.get("dag_vars", deserialize_json=True)
    print(dag_var)
    dbt_var = {
        "business_date": business_date, 
        "batch_id": batch_id,
        "source_system": source_system
    }    

    dbt_tg = DbtTaskGroup(
        project_config=ProjectConfig(
            dbt_project_path=DBT_ROOT_PATH,
            manifest_path= DBT_ROOT_PATH / "target/manifest.json"
        ),
        profile_config=profile_config,
        render_config=RenderConfig(
            load_method=LoadMode.DBT_MANIFEST,
            #By default cosmos generate dag that execute model and test for that model, if you don't want to use test then pass test_behavior=TestBehavior.NONE
            #test_behavior=TestBehavior.NONE
        ),
        operator_args = {"vars": dbt_var}
    )

    e2 = EmptyOperator(task_id="post_dbt")

    e1 >> tg1 >> dbt_tg >> e2