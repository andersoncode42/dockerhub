#!/bin/bash
# Script de instalação da imagem

set -eux
export DEBIAN_FRONTEND="noninteractive"

# Valida variáveis que deveriam está setadas pelo Dockerfile
if [ -z "${MY_LOCALE}" ]; then
    echo "variavel MY_LOCALE é obrigatoria"
    exit 1
fi

if [ -z "${MY_TIMEZONE}" ]; then
    echo "variavel MY_TIMEZONE é obrigatoria"
    exit 1
fi

echo "##== ATUALIZANDO SISTEMA ==##"
apt-get -y update
apt-get -y upgrade

echo "##== INSTALANDO PACOTES ==##"
apt-get install -y --no-install-recommends locales tzdata

echo "##== CONFIGURANDO LOCALE ==##"
locale-gen "$MY_LOCALE"
update-locale LANG="$MY_LOCALE"

echo "##== CONFIGURANDO TIMEZONE ==##"
dpkg-reconfigure -f noninteractive tzdata
echo "$MY_TIMEZONE" > /etc/timezone
ln -snf "/usr/share/zoneinfo/$MY_TIMEZONE" /etc/localtime

echo "##== LIMPANDO SISTEMA ==##"
apt-get -y clean
apt-get -y autoremove
rm -Rf /var/lib/apt/lists/*
rm -Rf /tmp/*