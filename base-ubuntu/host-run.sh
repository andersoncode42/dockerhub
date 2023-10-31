#!/bin/bash
set -e
imagem=$(basename "$PWD")
podman run --rm -it --name "$imagem" "$imagem":stable