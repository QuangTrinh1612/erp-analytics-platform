FROM apache/airflow:2.10.1-python3.12

USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
         vim \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

USER airflow
RUN python -m pip install --upgrade pip

COPY requirements.txt /
RUN pip install --no-cache-dir "apache-airflow==2.10.1" -r /requirements.txt