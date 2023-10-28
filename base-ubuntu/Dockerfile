FROM ubuntu:jammy-20231004
RUN apt-get -y update  \
&&  apt-get -y upgrade \
&& echo "##== INSTALANDO PACOTES NECESSARIOS ==##" \
&&  apt-get install -y --no-install-recommends     \
                    bash-completion \
                    locales  \
                    vim nano \
&& echo "##== LIMPANDO INSTALAÇÃO ==##" \
&&  apt-get -y clean      \
&&  apt-get -y autoremove \
&& rm -rf /var/lib/apt/lists/* \
&& locale-gen pt_BR.utf8  \
&&  update-locale LANG=pt_BR.utf8
              ENV LANG=pt_BR.utf8
CMD /bin/bash