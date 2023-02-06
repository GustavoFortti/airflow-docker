#!/bin/bash

function log_info() {
  local message=$1
  local timestamp=$(date +"%Y-%m-%d %T")
  echo "[INFO] ${timestamp} - ${message}"
}

function log_error() {
  local message=$1
  local timestamp=$(date +"%Y-%m-%d %T")
  echo "[ERROR] ${timestamp} - ${message}"
}

function check_cmd() {
  RETURN=$1; shift
  TYPE=$1; shift
  if [ $RETURN -eq 0 ]; then
    log_info "$TYPE : comando executado com sucesso"
  else
    log_error "Erro $TYPE"
    exit 1
  fi
}