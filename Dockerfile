FROM debian:stable-slim 
LABEL maintainer "Gabriel Schanuel <gabriel.schanuel@gmail.com>"

# docker run -it --rm \
#            -v /tmp/.X11-unix:/tmp/.X11-unix \
#            -v $HOME/Downloads:/home/banco/Downloads \
#            -e DISPLAY=unix$DISPLAY \
#            --name warsaw-browser \
#            lichti/warsaw-browser

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'deb http://ftp.br.debian.org/debian/ unstable main contrib non-free' >> /etc/apt/sources.list \
    && echo 'deb http://ftp.br.debian.org/debian/ sid main contrib non-free' >> /etc/apt/sources.list \
    && echo 'deb http://ftp.br.debian.org/debian/ experimental main contrib non-free' >> /etc/apt/sources.list

RUN apt update \
  && apt install -qqy \
  sudo \
  bash \
  bsdmainutils \
  libcom-err2 \
  libssl1.1 \
  openssl \
  dialog \
  firefox \
  libnss3-tools \
  --no-install-recommends \
#  && apt clean \
#  && rm -rf /var/lib/apt/lists/* \
  && groupadd -g 1000 -r banco \
  && useradd -u 1000 -r -m -g banco -G audio,video banco \
  && echo "banco ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
  && chmod 0440 /etc/sudoers \
  && passwd -d root \
  && mkdir /src

USER banco
ENV HOME /home/banco

#ADD https://cloud.gastecnologia.com.br/bb/downloads/ws/warsaw_setup64.deb /src/
ADD http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb7u4_amd64.deb /src
ADD https://cloud.gastecnologia.com.br/gas/diagnostico/warsaw-setup-ubuntu_64.deb /src

RUN dpkg -i /src/libssl1.0.0_1.0.1t-1+deb7u4_amd64.deb

COPY start.sh /src/start.sh

ENTRYPOINT ["/src/start.sh"]
