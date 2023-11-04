FROM andersoncode42/base-ubuntu:latest

# Pasta onde o java será instalado
ARG JAVA_HOME="/opt/java"

COPY ./image.sh /tmp/image.sh

RUN /tmp/image.sh "$JAVA_HOME"

ENV JAVA_HOME="$JAVA_HOME"
ENV JRE_HOME="$JAVA_HOME/bin"
ENV PATH="$PATH:$JRE_HOME"

CMD /bin/bash