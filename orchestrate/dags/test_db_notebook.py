import pendulum
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

CLUSTER_ID = Variable.get("poc_cluster_id")
LND_SCHEMA = "LND" 

# get params
dag_var = Variable.get("dag_vars", deserialize_json=True)
src_tgt_map = dag_var["src_tgt_map"]
business_date = dag_var["business_date"]
file_name = "CORE24-DE-ACCOUNT-STATUS-LOAN-"
source_system = dag_var["source_system"]
table_name = "LND.ACCOUNT_SAV_DE"

notebook_task = {
    "notebook_path": "/Shared/lloydsbank_poc/lnd/01_ingest_lnd_from_adls",
    "base_parameters": {
        "business_date": business_date,
        "file_name": file_name,
        "source_system": source_system,
        "table_name": table_name
    }
}

with DAG(
    dag_id="test_db_notebook",
    start_date=pendulum.datetime(2023, 11, 8),
    schedule=None,
) as dag:
    
    with TaskGroup(group_id='ingest_lnd_group') as tg1:
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

    tg1