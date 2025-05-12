#!/bin/bash
set -e
imagem=$(basename "$PWD")
docker run --rm -it --name "$imagem" "$imagem"