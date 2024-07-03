FROM docker.io/andersoncode42/base-ubuntu:latest AS imagem_instalacao

ENV LANG='pt_BR.UTF-8'
ENV TZ='America/Maceio'

COPY ./entrypoint.sh /tmp/entrypoint.sh
ENTRYPOINT [ "/bin/bash", "/tmp/entrypoint.sh" ]