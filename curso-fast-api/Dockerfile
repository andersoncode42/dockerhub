#----------------------------------------------------------------
# Fase 1: Imagem temporária para rodar o script de instalação
#----------------------------------------------------------------
FROM docker.io/andersoncode42/base-ubuntu:latest AS imagem_temporaria

COPY ./image-install.sh /tmp/image-install.sh
RUN /tmp/image-install.sh


#------------------------------------------------------------------------
# Fase 2: Criação da imagem final a partir do rootfs da fase anterior
#------------------------------------------------------------------------
FROM scratch AS imagem_final

COPY --from=imagem_temporaria / /

ENV LANG='pt_BR.UTF-8'
ENV TZ='America/Maceio'

CMD [ "/bin/bash" ]