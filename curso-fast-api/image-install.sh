#!/bin/bash
# No comando "set" abaixo NÃO use o parâmetro "-u" porque vai dá erro de unbold variable quando
# você usar o "source ~/.bashrc" porque ele referencia variáveis unbound, e o
# parâmetro "-u" considera isso um erro
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

# Estamos adicionando contéudo em ambos .bashrc e .profile
#
# Relembrando
# .profile -----> Para NÃO login tty (Dockerfile RUN)
# .bashrc ------> Para login tty (Dockerfile CMD)
#
# Curiosidades
# - O .bashrc verifica se é um bash interativo usando a variável "PS1"
# Se a variável estiver indefinida o .bashrc "return" antes de processar o resto do código dentro dele.
# - Como vc vai usar o comando  "source" DEVE desabilitar a opção "-u" do comando "set".
#   isso vale para ambos .bashrc e .profile, pois ambos fazem validações de variáveis que se encontram indefinidas/unbounds
echo "--------------------------------------------"
echo "Configurando .profile  e carregando o mesmo "
echo "--------------------------------------------"
# Configurando
echo 'export PYENV_ROOT="$HOME/.pyenv"' | tee -a ~/.profile ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' | tee -a ~/.profile ~/.bashrc
echo 'eval "$(pyenv init -)"' | tee -a ~/.profile ~/.bashrc
# Carregando
source ~/.profile

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

# echo "-------------------------------------------------"
# echo "Reabra o bash já com o comando pyenv disponível  "
# echo "-------------------------------------------------"
# exec "/bin/bash"