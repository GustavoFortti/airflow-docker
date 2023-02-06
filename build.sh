#!/bin/bash

source ./shared/message.sh
source ./shared/parse_args.sh

BUILD_IMAGE=0
CONTAINER_FLAG=0
APPLICATION_NAME="airflow"

parse_args $@

IMAGE_ID="$(docker images -q $APPLICATION_NAME)"

if [[ "$BUILD_IMAGE" -eq 1 && -n "$IMAGE_ID" ]]; then
  log_info "Deletando imagem..."
  docker rmi -f $IMAGE_ID
  IMAGE_ID=""
fi

CONTAINER_RUNNING=$(docker ps --filter name=$APPLICATION_NAME -q --format '{{.Names}}')

if [[ -z "$IMAGE_ID" || "$BUILD_IMAGE" -eq 2 ]]; then
  if [ -n "$CONTAINER_RUNNING" ]; then
    log_info "Deletando container $APPLICATION_NAME..."
    docker rm -f $APPLICATION_NAME
  fi

  log_info "Criando imagem..."
  docker build -t "$APPLICATION_NAME" . --quiet
  check_cmd $? "docker build -t '$APPLICATION_NAME' . --quiet"
  CONTAINER_FLAG=1
fi

if [[ -z "$CONTAINER_RUNNING" || $CONTAINER_FLAG -eq 1 ]]; then
  CONTAINER_NAME=$(docker ps -a --filter name=$APPLICATION_NAME -q --format '{{.Names}}')
  if [ -z "$CONTAINER_NAME" ]; then
    log_info "Criando container..."
    docker run -d --name "$APPLICATION_NAME" -p 8080:8080 "$APPLICATION_NAME"
    check_cmd $? "docker run -d --name '$APPLICATION_NAME' -p 8080:8080 '$APPLICATION_NAME'"
  else
    log_info "Iniciando container..."
    docker start -ai "$APPLICATION_NAME"
  fi
else
  log_info "O container já está em execução"
fi

log_info "container em execução"
docker ps --filter name=$APPLICATION_NAME