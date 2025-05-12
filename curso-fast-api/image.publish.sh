#!/bin/bash

#==============
# OBJETIVO
#==============
# Publicar a  imagem anteriormente "buildada" para o dockerhub
#
# Pré-requisitos
# - A imagem está "buildada"
# - O terminal já está logado através do docker login

set -e
imagem=$(basename "$PWD")
urilocal="localhost/$imagem"
uriremota="docker.io/andersoncode42/$imagem:latest"

# Se existe tag local, renomeie para tag remota
if docker images | grep -q "$urilocal"; then
    echo "Renomeando tag local para tag remota"
    docker tag "$urilocal" "$uriremota"
fi

echo "Tentando dá push da imagem $uriremota"
docker push "$uriremota"