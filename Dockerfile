#
# Debian Jessie Desktop (MATE) Dockerfile with QGIS
#
# https://github.com/DigitalGlobe/debian-desktop 
#

# Pull base image.
FROM debian:jessie 

# Install MATE and VNC server.
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install --fix-missing -y mate-desktop-environment-core tightvncserver && \
  rm -rf /var/lib/apt/lists/*

RUN dpkg --add-architecture i386 && \
    apt-get update --yes --quiet && \
    apt-get install --yes --quiet --no-install-recommends \
        wget xz-utils libc6:i386 libdbus-1-3 libasound2 libsm6 libxfixes3 \
        libdbus-1-3:i386 libasound2:i386 libexpat1:i386 libfontconfig1:i386 \
        libfreetype6:i386 libjpeg62:i386 libpng12-0:i386 libsm6:i386 \
        libxdamage1:i386 libxext6:i386 libxfixes3:i386 libxinerama1:i386 \
        libxrandr2:i386 libxrender1:i386 libxtst6:i386 zlib1g:i386 && \
    wget --no-check-certificate -q -O /tmp/teamviewer_i386.tar.xz "http://download.teamviewer.com/download/teamviewer_i386.tar.xz" && \
    tar xf /tmp/teamviewer_i386.tar.xz -C /opt/ && \
    rm /tmp/teamviewer_i386.tar.xz && \
    apt-get remove --auto-remove --yes --purge wget && \
    apt-get clean --yes && \
    rm -rf /var/lib/apt/lists/*
# Define working directory.
WORKDIR /data

# Define default command.
#CMD ["bash"]

# Expose ports.
EXPOSE 5901
#USER root

#RUN echo "deb     http://qgis.org/debian jessie main" >> /etc/apt/sources.list
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key 3FF5FFCAD71472C4
#RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y qgis python-qgis qgis-plugin-grass
#RUN mkdir /root/.vnc && echo "debian" | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd
#CMD vncserver :1
