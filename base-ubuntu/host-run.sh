#!/bin/bash
set -e
imagem=$(basename "$PWD")
podman run --rm --replace -it --name "$imagem" "$imagem"