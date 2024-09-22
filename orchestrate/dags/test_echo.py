import pendulum
import os

from pathlib import Path
from airflow import DAG
from airflow.operators.bash import BashOperator 

with DAG(
    dag_id="test_echo",
    start_date=pendulum.datetime(2023, 11, 8),
    schedule=None,
) as dag:
    run_id = BashOperator(
        task_id='run_id',
        bash_command="echo {{ dag_run.run_id }}"
    )

    dag_id = BashOperator(
        task_id='dag_id',
        bash_command="echo {{ dag_run.dag_id }}"
    )

    run_id
    dag_id