#----------------------------------------------------------------
# Fase 1: Instalação
#----------------------------------------------------------------
FROM docker.io/andersoncode42/base-ubuntu:latest AS imagem_instalacao
COPY ./imagem_instalacao.sh /tmp/imagem_instalacao.sh
RUN bash -x /tmp/imagem_instalacao.sh
CMD /bin/bash

#----------------------------------------------------------------
# Fase 2: Ajustes
#----------------------------------------------------------------
FROM imagem_instalacao AS imagem_ajustes
COPY ./imagem_ajustes.sh /tmp/imagem_ajustes.sh
# RUN bash -x /tmp/imagem_ajustes.sh
RUN bash -x /tmp/imagem_ajustes.sh
CMD /bin/bash

#------------------------------------------------------------------------
# Fase 3: Final
#------------------------------------------------------------------------
FROM scratch AS imagem_final

# Copie o rootfs da imagem anterior para a nova imagem
COPY --from=imagem_ajustes / /

ENV LANG='pt_BR.UTF-8'
ENV TZ='America/Maceio'

CMD /bin/bash