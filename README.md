<h1>
    <img
        src="asset\logo.svg"
        alt="ERP Data Analytics logo"
        height=50
    />
    ERP Data Analytics Platform
</h1>

## Project Overview
This project demonstrates how to build a data pipeline using **dbt** for data modeling and **Apache Airflow** for orchestration. The pipeline includes building dbt models and orchestrating them through Airflow to automate data processing and transformation tasks.

## Table of Contents
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
- [Running the Project](#running-the-project)
- [Airflow DAG](#airflow-dag)
- [dbt Models](#dbt-models)
- [Configuration](#configuration)
- [Testing](#testing)

---

## Project Structure
```plaintext
/my_project
│
├── /airflow
│   ├── /dags
│   │   └── dbt_dag.py            # DAG for orchestrating dbt runs via Airflow
│   ├── /plugins
│   └── /config
│       └── airflow.cfg           # Airflow configuration files
│
├── /dbt
│   ├── /models
│   │   ├── /staging
│   │   ├── /warehouse
│   │   └── /analytics
│   │       └── my_model.sql      # SQL files for dbt models
│   ├── /seeds
│   ├── /macros
│   ├── /tests
│   ├── /snapshots
│   └── dbt_project.yml           # dbt project configuration
│
├── /scripts
│   └── dbt_run.sh                # Shell script to execute dbt commands
│
├── /logs
│   └── airflow_logs              # Airflow logs
│
├── /config
│   ├── airflow_env.yml           # Airflow environment variables/config
│   └── dbt_profiles.yml          # dbt profiles configuration
│
├── /docs
│   └── README.md                 # Project documentation
│
└── /tests
    └── test_dbt_airflow.py        # Unit and integration tests
```

## Setup Instructions
### Prerequisites
Ensure you have the following tools installed:
- dbt (version >= 1.0)
- Apache Airflow (version >= 2.0)
- PostgreSQL or your preferred database engine
- Python 3.8 or higher
- Virtual environment tools (e.g., venv, virtualenv, or conda)
### Step 1: Clone the Repository
```bash
git clone https://github.com/your-username/my_project.git
cd my_project
```

### Step 2: Set up Python Virtual Environment
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### Step 3: Install and Configure Airflow
```bash
airflow db init
airflow webserver --port 8080  # Start the Airflow webserver
airflow scheduler               # Start the Airflow scheduler
```

### Step 4: Set up dbt
- Edit the `dbt_profiles.yml` file in `/config/` to include your database credentials and connection information.

- Run the following commands to initialize dbt:

    ```bash
    cd dbt/
    dbt debug           # Check dbt configuration
    dbt run             # Execute the dbt models
    dbt test            # Run tests
    ```

### Step 5: Configure Environment Variables
Ensure the environment variables for Airflow and dbt are properly set. You can define these in the `airflow_env.yml` and `dbt_profiles.yml` configuration files.

## Running the Project
- Ensure the Airflow web server and scheduler are running.
    ```bash
    airflow webserver
    airflow scheduler
    ```

- Run the dbt models via Airflow by triggering the appropriate DAG:
    - Navigate to Airflow UI and trigger the `dbt_dag`.

## Airflow DAG
The Airflow DAG file is located in `/airflow/dags/dbt_dag.py`. It contains the following tasks:

- `dbt_run`: Executes dbt run to build models.
- `dbt_test`: Executes dbt test to run dbt tests.

You can customize the DAG based on your specific dbt models and workflows.

## dbt Models
dbt models are organized under `/dbt/models` into logical layers such as:
- staging: Raw data transformations.
- warehouse: Refined models.
- analytics: Business-specific analytical models.

## Configuration
### Airflow
Airflow configuration is stored in:
- `/airflow/config/airflow.cfg` - General Airflow configuration.
- `/config/airflow_env.yml` - Environment variables for Airflow.
### dbt
dbt configuration is defined in:
- `/dbt/dbt_project.yml` - The main configuration file for dbt.
- `/config/dbt_profiles.yml` - Profile for connecting dbt to your database.

## Testing
To run unit and integration tests for both dbt and Airflow:
- Ensure your virtual environment is activated.
- Run tests using:
    ```bash
    pytest /tests/test_dbt_airflow.py
    ```

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Contact
For any questions or issues, please contact trinhquocquang.buh@gmail.com.
This `README.md` provides an organized guide for setting up, running, and understanding the project. You can further customize it based on your project specifics.