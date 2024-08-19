FROM docker.io/ubuntu:latest

# RUN bash -c "passwd -l root && usermod -s /usr/sbin/nologin root"

# Cria um novo usuário e grupo
RUN echo "exit 1" > /etc/profile && groupadd -r meuusuario && useradd -r -g meuusuario meuusuario

# Definir o novo usuário como o usuário padrão
USER meuusuario

CMD /usr/bin/test "$UID" = "0" && echo 'hello' || echo 'oi'