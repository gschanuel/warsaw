FROM ubuntu:artful
LABEL maintainer "Gabriel Schanuel <gabriel.schanuel@gmail.com>"

# Baixar o Firefox e o Warsaw 
#ADD https://cloud.gastecnologia.com.br/bb/downloads/ws/warsaw_setup64.deb /src/
ADD https://cloud.gastecnologia.com.br/gas/diagnostico/warsaw-setup-ubuntu_64.deb /src/warsaw_setup64.deb
ADD https://ufpr.dl.sourceforge.net/project/ubuntuzilla/mozilla/apt/pool/main/f/firefox-mozilla-build/firefox-mozilla-build_57.0.4-0ubuntu1_amd64.deb /src/firefox.deb

ENV DEBIAN_FRONTEND noninteractive
RUN echo 'deb http://archive.canonical.com/ubuntu artful partner' >> /etc/apt/sources.list
RUN apt update \
	# Instalar as dependencias do Firefox
	&& apt install -qqy $(apt-cache depends firefox | awk '$1~/Depends/{printf $2" "}') \
	# Instalar os outros pacotes necessários
	sudo \
	apt-transport-https \
	ca-certificates \
	fonts-symbola \
	gnupg \
#	firefox \
	adobe-flashplugin \
	hicolor-icon-theme \
	language-pack-pt \
	libcurl3 \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libnss3-tools \
	libpango1.0-0 \
	libpulse0 \
	libv4l-0 \
	openssl \
	dbus \
	sudo \
	x11-apps \
	x11-utils \
	xauth \
	libdbusmenu-glib4 \
	libdbusmenu-gtk3-4 \
	--no-install-recommends \
	# Instalar o firefox 57 a partir do deb
	#&& apt -y install /src/firefox-mozilla-build_57.0.4-0ubuntu1_amd64.deb \
	&& apt -y install /src/firefox.deb \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/* 

#Criar o usuário e adiciona-lo ao sudoers
RUN 	useradd -m -u 1000 -r -G audio,video banco \
	&& mkdir -p /home/banco/Downloads \
	&& echo "banco ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
	&& chmod 0440 /etc/sudoers \
	&& passwd -d root

# Copiar o Script de inicialização e setar suas permissões
COPY	start.sh /home/banco/start.sh
RUN	chmod 755 /home/banco/start.sh \
	&& ln -s /home/banco/start.sh /usr/local/bin/start.sh

#COPY local.conf /etc/fonts/local.conf

USER banco
ENV HOME /home/banco

CMD ["/home/banco/start.sh"]
