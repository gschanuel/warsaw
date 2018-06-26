FROM ubuntu:latest
LABEL maintainer "Gabriel Schanuel <gabriel.schanuel@gmail.com>"

# docker run -it --rm \
#            -v /tmp/.X11-unix:/tmp/.X11-unix \
#            -v $HOME/Downloads:/home/banco/Downloads \
#            -e DISPLAY=unix$DISPLAY \
#            --name warsaw-browser \
#            lichti/warsaw-browser

ENV DEBIAN_FRONTEND noninteractive

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
aspell-en \
ca-certificates \
dirmngr \
enchant \
gnupg \
gnupg-l10n \
gnupg-utils \
gpg \
gpg-agent \
gpg-wks-client \
gpg-wks-server \
gpgconf \
gpgsm \
gpgv \
gstreamer1.0-gl \
gstreamer1.0-plugins-base \
gstreamer1.0-plugins-good \
gstreamer1.0-pulseaudio \
gstreamer1.0-x \
hunspell-en-us \
iso-codes \
libaa1 \
libasn1-8-heimdal \
libassuan0 \
libasyncns0 \
libavc1394-0 \
libcaca0 \
libcap2 \
libcap2-bin \
libcdparanoia0 \
libcurl3 \
libdrm-amdgpu1 \
libdrm-intel1 \
libdrm-nouveau2 \
libdrm-radeon1 \
libdv4 \
libedit2 \
libelf1 \
libenchant1c2a \
libflac8 \
libgail-common \
libgail18 \
libgl1 \
libgl1-mesa-dri \
libglx-mesa0 \
libglx0 \
libgpgme11 \
libgpm2 \
libgraphene-1.0-0 \
libgssapi3-heimdal \
libgstreamer-gl1.0-0 \
libgstreamer-plugins-base1.0-0 \
libgstreamer-plugins-good1.0-0 \
libgstreamer1.0-0 \
libgtk2.0-0 \
libgtk2.0-bin \
libgtk2.0-common \
libgudev-1.0-0 \
libharfbuzz-icu0 \
libhcrypto4-heimdal \
libheimbase1-heimdal \
libheimntlm0-heimdal \
libhunspell-1.6-0 \
libhx509-5-heimdal \
libhyphen0 \
libiec61883-0 \
libjack-jackd2-0 \
libjavascriptcoregtk-4.0-18 \
libkrb5-26-heimdal \
libksba8 \
libldap-2.4-2 \
libldap-common \
libllvm6.0 \
libmp3lame0 \
libmpg123-0 \
libnghttp2-14 \
libnotify4 \
libnpth0 \
libogg0 \
libopus0 \
liborc-0.4-0 \
libpam-cap \
libpciaccess0 \
libpsl5 \
libpulse0 \
libpython-stdlib \
libpython2.7-minimal \
libpython2.7-stdlib \
libraw1394-11 \
libroken18-heimdal \
librtmp1 \
libsamplerate0 \
libsasl2-2 \
libsasl2-modules \
libsasl2-modules-db \
libsecret-1-0 \
libsecret-common \
libsensors4 \
libshout3 \
libslang2 \
libsndfile1 \
libspeex1 \
libssl1.0.0 \
libtag1v5 \
libtag1v5-vanilla \
libtheora0 \
libtwolame0 \
libv4l-0 \
libv4lconvert0 \
libvisual-0.4-0 \
libvorbis0a \
libvorbisenc2 \
libvpx5 \
libwavpack1 \
libwebkit2gtk-4.0-37 \
libwebp6 \
libwebpdemux2 \
libwind0-heimdal \
libwrap0 \
libxcb-glx0 \
libxslt1.1 \
libxv1 \
libxxf86vm1 \
notification-daemon \
pinentry-curses \
publicsuffix \
python \
python-asn1crypto \
python-cffi-backend \
python-cryptography \
python-enum34 \
python-gpg \
python-idna \
python-ipaddress \
python-minimal \
python-openssl \
python-six \
python2.7 \
python2.7-minimal \
zenity \
zenity-common \
  --no-install-recommends \
#  && apt clean \
#  && rm -rf /var/lib/apt/lists/* \
  && groupadd -g 1000 -r banco \
  && useradd -u 1000 -r -m -g banco -G audio,video banco \
  && echo "banco ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
  && chmod 0440 /etc/sudoers \
  && passwd -d root \
  && mkdir /src


ADD https://cloud.gastecnologia.com.br/gas/diagnostico/warsaw-setup-ubuntu_64.deb /src

RUN dpkg -i /src/warsaw-setup-ubuntu_64.deb 
COPY start.sh /src/start.sh
RUN touch /src/first

USER banco
ENV HOME /home/banco

#RUN firefox -CreateProfile default

ENTRYPOINT ["/src/start.sh"]
