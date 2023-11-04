#!/bin/bash

# Objetivo: Instalar o openjdk no container
# Cuidados: Deve-se exportar as variáveis de ambiente (JAVA_HOME e JRE_HOME) no Dockerfile
#           e o path deve coincidir com o path onde o script instalou o java

set -e
export DEBIAN_FRONTEND="noninteractive"

JAVA_HOME="$1"  # O local onde o java será instalado. O parâmetro do script é fornecido pelo Dockerfile
WORKDIR="/tmp"  # Local onde faremos as operações temporárias

# IMPORTANTE: Quando sair uma nova versão, altere o nessa variável
FILENAME="OpenJDK18U-jdk_x64_linux_hotspot_18.0.2.1_1.tar.gz"

URL="https://github.com/adoptium/temurin18-binaries/releases/download/jdk-18.0.2.1%2B1/$FILENAME"

FILE="$WORKDIR/$FILENAME"


echo "##== Atualiza Sistema ==##"
apt-get -y update
apt-get -y upgrade

echo "##== Download ==##"
echo "Fazendo o download da url: $URL"
wget -O "$FILE" "$URL"

echo "##== Descompacta ==##"
echo "Extraindo o arquivo $FILE na pasta $WORKDIR"
tar -xvzf "$FILE" -C "$WORKDIR"

echo "##== Instala ==##"
echo "Move/renomeia a pasta descompactada para o local definitivo"
mv -v /tmp/jdk-* "$JAVA_HOME"
echo "Java instalado na pasta: $JAVA_HOME"

echo "##== Limpa o Sistema ==##"
apt-get -y clean
apt-get -y autoremove
rm -Rfv /var/lib/apt/lists/*
# IMPORTANTE: Nesse caso "WORKDIR" já é "/tmp"
#             Caso  vc utilize um path diferente para "WORKDIR" vc também DEVERÁ
#             excluir ele explicitamente: "rm -RFv $WORKDIR"
rm -Rfv /tmp/*
