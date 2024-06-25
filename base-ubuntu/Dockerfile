#==================================
# ARGs GLOBAIS
#==================================
ARG MY_LOCALE='pt_BR.UTF-8'
ARG MY_TIMEZONE='America/Maceio'
ARG MY_VERSION='24.04' # Usado apenas pelo 1st Estágio, deve ser declarado antes

FROM docker.io/ubuntu:${MY_VERSION} AS imagem_temporaria
ARG MY_LOCALE
ARG MY_TIMEZONE

# Copiando o arquivo de instalação da imagem
# COPY ./image.sh /tmp/image.sh

# RUN /tmp/image.sh && rm -v /tmp/image.sh


RUN set -eux && \
export DEBIAN_FRONTEND="noninteractive"    && \
export PACOTES="locales tzdata"            && \
echo "##== ATUALIZANDO SISTEMA ==##"       && \
apt-get -y update                          && \
apt-get -y upgrade                         && \
echo "##== INSTALANDO PACOTES ==##"        && \
apt-get install -y --no-install-recommends $PACOTES  && \
echo "##== CONFIGURANDO LOCALE ==##"       && \
locale-gen "${MY_LOCALE}"                  && \
update-locale LANG="${MY_LOCALE}"          && \
echo "##== CONFIGURANDO TIMEZONE ==##"     && \
dpkg-reconfigure -f noninteractive tzdata  && \
echo "${MY_TIMEZONE}" > /etc/timezone      && \
ln -snf /usr/share/zoneinfo/${MY_TIMEZONE} /etc/localtime && \
echo "##== LIMPANDO SISTEMA ==##"          && \
apt-get -y purge $PACOTES                  && \
apt-get -y clean                           && \
apt-get -y autoremove                      && \
rm -Rf /var/lib/apt/lists/*                && \
rm -Rf /tmp/*

# Fase 2: Criação da imagem final a partir do rootfs da fase anterior
FROM scratch AS imagem_final
ARG MY_LOCALE
ARG MY_TIMEZONE

ENV LANG="${MY_LOCALE}"
# Variável necessária para o comando date reletir o valor certo
ENV TZ="${MY_TIMEZONE}}"

# Copie o rootfs da imagem anterior para a nova imagem
COPY --from=imagem_temporaria / /

CMD /bin/bash