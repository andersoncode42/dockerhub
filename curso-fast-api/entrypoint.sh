#!/bin/bash
# No "set"não use o parâmetro "u" porque vai dá erro de unbold variable quando 
# você usar o source ~/.bashrc porque a variável PS1 não está setada
set -ex;
export DEBIAN_FRONTEND=noninteractive

apt -y update
apt -y upgrade

echo "-------------------------------------"
echo "Instalando Pré-Requisitos do pyenv   "
echo "-------------------------------------"
apt -y install curl
apt -y install git
apt -y install build-essential
apt -y install python3-all
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
# zipimport.ZipImportError: can't decompress data; zlib not available
apt -y install zlib1g-dev

echo "----------------------"
echo "Instalando pyenv      "
echo "----------------------"
curl https://pyenv.run | bash

# Não use .bashrc
# Ele faz uma verificação para ver se é um bash interativo
# Como esse não é o caso, o .bashrc finaliza ele mesmo antes de processar
# o resto do código dentro dele.
# A título de curiosidade ele faz essa validação testando a existencia da variável PS!
echo "--------------------------------------------"
echo "Configurando .profile  e carregando o mesmo "
echo "--------------------------------------------"
# Configurando
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init -)"' >> ~/.profile
# Carregando
source ~/.profile

echo "----------------------"
echo "Atualizando pyenv     "
echo "----------------------"
pyenv update

echo "----------------------------------------------"
echo "Buildando a versão do python que eu preciso   "
echo "----------------------------------------------"
# pyenv install 3.12.4
# pyenv global 3.12.4
# pip install --upgrade pip

echo "----------------------------------- "
echo "Limpando a instalação               "
echo "------------------------------------"
apt -y autoremove
rm -rfv /var/lib/apt/lists/*

echo "SUCESSO !!!"

echo "-------------------------------------------------"
echo "Reabra o bash já com o comando pyenv disponível  "
echo "-------------------------------------------------"
exec "/bin/bash"