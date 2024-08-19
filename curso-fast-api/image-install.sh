#!/bin/bash
# No comando "set" abaixo NÃO use o parâmetro "-u" porque vai dá erro de "unbold variable" quando
# você usar o "source ~/.bashrc" porque ele referencia variáveis unbound, e o
# parâmetro "-u" considera isso um erro
set -ex;
export DEBIAN_FRONTEND=noninteractive

echo "-------------------------------------"
echo "Atualiza a lista de pacotes apt      "
echo "-------------------------------------"
apt -y update
apt -y upgrade

echo "-------------------------------------"
echo "pyenv - Pré-Requisitos               "
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

echo "---------------------"
echo "pyenv - Instalação   "
echo "---------------------"
curl https://pyenv.run | bash

echo "-----------------------"
echo "pyenv - Configuração   "
echo "-----------------------"

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

# Configurando
echo 'export PYENV_ROOT="$HOME/.pyenv"' | tee -a ~/.profile ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' | tee -a ~/.profile ~/.bashrc
echo 'eval "$(pyenv init -)"' | tee -a ~/.profile ~/.bashrc

# Carregando
source ~/.profile

echo "----------------------"
echo "pyenv - Atualização   "
echo "----------------------"
pyenv update

echo "------------------------------------------------------"
echo "pyenv - Buildando a versão do python que eu preciso   "
echo "------------------------------------------------------"
pyenv install 3.12.4
pyenv global 3.12.4

echo "--------------------"
echo "pip - Atualização   "
echo "--------------------"
pip install --upgrade pip

echo "-------------------------------------------------"
echo "pipx - Instalação                      "
echo "-------------------------------------------------"
pip install pipx

echo "----------------------"
echo "pipx - Configuração   "
echo "----------------------"
# As duas linhas abaixo é devido à mensagem abaixo
#---> ⚠️  Note: '/root/.local/bin' is not on your PATH environment variable. These apps will not be globally accessible until your
#---> PATH is updated. Run `pipx ensurepath` to automatically add it, or manually modify your PATH in your shell's config file (e.g. ~/.bashrc).
pipx ensurepath
source ~/.bashrc

echo "----------------------"
echo "poetry - Instalação   "
echo "----------------------"
pipx install poetry

echo "----------------------------------- "
echo "Limpando a instalação (apt)         "
echo "------------------------------------"
apt -y autoremove
rm -rfv /var/lib/apt/lists/*

echo "SUCESSO !!!"