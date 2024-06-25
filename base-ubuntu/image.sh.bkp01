#!/bin/bash
set -e
export DEBIAN_FRONTEND="noninteractive"

PACOTES="locales tzdata"

echo "##== ATUALIZANDO SISTEMA ==##"
apt-get -y update
apt-get -y upgrade

echo "##== INSTALANDO PACOTES ==##"
apt-get install -y --no-install-recommends "$PACOTES"

echo "##== CONFIGURANDO LOCALE ==##"
locale-gen pt_BR.utf8
update-locale LANG=pt_BR.utf8

echo "##== CONFIGURANDO TIMEZONE ==##"
dpkg-reconfigure -f noninteractive tzdata
echo "America/Bahia" > /etc/timezone

echo "##== LIMPANDO SISTEMA ==##"
apt-get -y remove "$PACOTES"
apt-get -y clean
apt-get -y autoremove
rm -Rf /var/lib/apt/lists/*
rm -Rf /tmp/*