#!/bin/bash

help() {
  echo "Comandos disponíveis para o build:"
  echo "  -b | usado para manipuilar a imagem docker"
  echo "       1 = deleta a imagem usada pelo container e cria uma nova"
  echo "       2 = cria uma nova imagem a partir da antiga"
}

function parse_args() {
  while [[ $# -gt 0 ]]
  do
    key="$1"
    shift
    case $key in
        -b)
        BUILD_IMAGE="$1"
        shift # past value
        ;;
        -help)
        help
        exit 0
        ;;
        *)
        log_info "Erro: Argumento inválido: $1"
        exit 2
        ;;
    esac
  done
}