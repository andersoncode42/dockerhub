#!/bin/bash
source ~/.bashrc

set -eux;

export DEBIAN_FRONTEND=noninteractive

apt -y update
apt -y upgrade

echo "----------------------------------------------------------------------------"
echo "Resolvendo problemas de dependências para poder buildar versões do python   "
echo "----------------------------------------------------------------------------"
# "ERROR: The Python ssl extension was not compiled. Missing the OpenSSL lib?"
apt -y install libssl-dev
# ModuleNotFoundError: No module named '_bz2'
apt -y install libbz2-dev
# ModuleNotFoundError: No module named '_ctypes'
apt -y install libffi-dev
# ModuleNotFoundError: No module named 'readline'
apt -y install libreadline-dev
# ModuleNotFoundError: No module named '_sqlite3'
apt -y install libsqlite3-dev
# ModuleNotFoundError: No module named '_lzma'
apt -y install liblzma-dev

echo "----------------------"
echo "Atualizando pyenv     "
echo "----------------------"
pyenv update

echo "----------------------------------------------"
echo "Buildando a versão do python que eu preciso   "
echo "----------------------------------------------"
pyenv install 3.12.4
pyenv global 3.12.4
pip install --upgrade pip

echo "----------------------------------- "
echo "Limpando a instalação               "
echo "------------------------------------"
apt -y autoremove
rm -rfv /var/lib/apt/lists/*

echo "SUCESSO !!!"