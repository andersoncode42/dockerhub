set -ex;

echo "-------------------------------------"
echo "Atualiza a lista de pacotes apt      "
echo "-------------------------------------"
apk update --no-cache
apk upgrade --no-cache

apk add --no-cache bash
apk add --no-cache python3 py3-pip py3-virtualenv pipx

# Cria o Grupo, que tem o mesmo id e nome do usuário
echo "$MYID ---> $MYUSER"
addgroup -g "$MYID" "$MYUSER"
# Cria meu usario
adduser -u "$MYID" -G "$MYUSER" -h "/home/$MYUSER" -s /bin/bash -D "$MYUSER"


