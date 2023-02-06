#!/bin/bash

source ./shared/message.sh

APPLICATION_NAME="airflow"
CONTAINER_RUNNING=$(docker ps --filter name=$APPLICATION_NAME -q --format '{{.Names}}')

if [ -n "$CONTAINER_RUNNING" ]; then
    log_info "copiando DAGs para o container..."
    docker ps --filter name=$APPLICATION_NAME
    docker cp ./app/dags/* $APPLICATION_NAME:/root/airflow/dags
    check_cmd $? "docker cp nova_dag.py nome_do_meu_container:/opt/airflow/dags/"
fi