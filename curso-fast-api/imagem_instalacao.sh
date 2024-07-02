#!/bin/bash
set -eux;
export DEBIAN_FRONTEND=noninteractive

apt -y update
apt -y upgrade

#echo "---------------------------------"
#echo "Instalando Pré-Requisitos Gerais "
#echo "---------------------------------"
#apt -y install locales
#apt -y install language-pack-pt-base


#echo "------------------------"
#echo "Configurando locale     "
#echo "------------------------"
#echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
#locale-gen pt_BR.UTF-8

echo "-------------------------------------"
echo "Instalando Pré-Requisitos do pyenv   "
echo "-------------------------------------"
apt -y install curl
apt -y install git
# Senão dá o erro "configure: error: no acceptable C compiler found in $PATH"
apt -y install build-essential
# Precisa do python
# apt -y install python3-dev
apt -y install python3-all

echo "O valor de PS1 é: $PS1"

echo "----------------------"
echo "Instalando pyenv      "
echo "----------------------"
curl https://pyenv.run | bash

echo "----------------------------------"
echo "Setando vars do pyenvno .bashrc   "
echo "----------------------------------"
export PS1=""
echo "O valor de PS1 é: $PS1"

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

source ~/.bashrc
pyenv versions

echo "----------------------------------- "
echo "Limpando a instalação               "
echo "------------------------------------"
apt -y autoremove
rm -rfv /var/lib/apt/lists/*

echo "SUCESSO !!!"

echo "----------------------------------------------------------------"
echo "Reiniciando o Shell para o terminal reconhecer o comando pyenv  "
echo "----------------------------------------------------------------"
exec "/bin/bash"