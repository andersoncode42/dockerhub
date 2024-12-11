#==================================
# ARGs GLOBAIS
#==================================
ARG MY_LOCALE='pt_BR.UTF-8'
ARG MY_TIMEZONE='America/Maceio'
ARG MY_VERSION='24.04' # Usado apenas pelo 1st Estágio, deve ser declarado antes

#----------------------------------------------------------------
# Fase 1: Imagem temporária para rodar o script de instalação
#----------------------------------------------------------------
FROM docker.io/ubuntu:${MY_VERSION} AS imagem_temporaria
ARG MY_LOCALE
ARG MY_TIMEZONE

# Copiando o arquivo de instalação da imagem
COPY ./image-install.sh /tmp/image-install.sh
RUN bash -x /tmp/image-install.sh

#------------------------------------------------------------------------
# Fase 2: Criação da imagem final a partir do rootfs da fase anterior
#------------------------------------------------------------------------
FROM scratch AS imagem_final
ARG MY_LOCALE
ARG MY_TIMEZONE

ENV LANG="${MY_LOCALE}"
# Variável necessária para o comando date reletir o valor certo
# Sem isso não funciona
ENV TZ="${MY_TIMEZONE}"

# Copie o rootfs da imagem anterior para a nova imagem
COPY --from=imagem_temporaria / /

CMD /bin/bash