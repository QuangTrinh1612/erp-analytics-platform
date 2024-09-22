import pendulum
import os

from pathlib import Path
from airflow import DAG
from airflow.operators.bash import BashOperator 

DBT_PROJECT_NAME = Path(os.getenv("DBT_PROJECT_NAME", "lloyds_bank"))
DEFAULT_DBT_ROOT_PATH = Path(__file__).parent.parent / "dbt" / DBT_PROJECT_NAME
DBT_ROOT_PATH = Path(os.getenv("DBT_ROOT_PATH", DEFAULT_DBT_ROOT_PATH))

with DAG(
    dag_id="test_dbt_cmd",
    start_date=pendulum.datetime(2023, 11, 8),
    schedule=None,
) as dag:
    dbt_deps = BashOperator(
        task_id='dbt_deps',
        bash_command=f'cd "{DBT_ROOT_PATH}" && dbt deps'
    )

    dbt_compile = BashOperator(
        task_id='dbt_compile',
        bash_command=f'cd "{DBT_ROOT_PATH}" && dbt compile',
        dag=dag
    )

    dbt_deps >> dbt_compile