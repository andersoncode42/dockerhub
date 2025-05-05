#!/bin/bash
set -e
imagem=$(basename "$PWD")

# Elimina os containers para poder reconstruir a imagem
docker container rm --force imagem
docker build --no-cache --rm -t "$imagem":latest .
