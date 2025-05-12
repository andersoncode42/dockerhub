ARG MYID='1000'
ARG MYUSER='usuario'

#----------------------------------------------------------------
# Fase 1: Imagem temporária para rodar o script de instalação
#----------------------------------------------------------------

# 3.21.3 em 12/05/2025
FROM docker.io/alpine@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c AS imagem_temporaria
ARG MYID
ARG MYUSER

COPY ./bootstrap.sh /tmp/bootstrap.sh

# Usadoa no script
ENV MYID=$MYID
ENV MYUSER=$MYUSER

RUN /tmp/bootstrap.sh


#------------------------------------------------------------------------
# Fase 2: Criação da imagem final a partir do rootfs da fase anterior
#------------------------------------------------------------------------
FROM scratch AS imagem_final
ARG MYID
ARG MYUSER

COPY --from=imagem_temporaria / /

ENV LANG='pt_BR.UTF-8'
ENV TZ='America/Maceio'

ENV USER="$MYUSER"
ENV PS1="\u@\h:\w\$ "

USER $MYUSER
WORKDIR /home/$MYUSER

CMD [ "/bin/bash" ]