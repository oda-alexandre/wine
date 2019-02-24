FROM debian:stretch-slim

MAINTAINER https://oda-alexandre.github.io

# INSTALLATION DES PREREQUIS
RUN apt-get update && apt-get install -y --no-install-recommends \
sudo \
locales \
ca-certificates \
software-properties-common \
apt-transport-https \
gnupg \
wget

# SELECTION DE LA LANGUE FRANCAISE
ENV LANG fr_FR.UTF-8
RUN echo fr_FR.UTF-8 UTF-8 > /etc/locale.gen && locale-gen

# AJOUT DE L'UTILISATEUR
RUN useradd -d /home/wine -m wine && \
passwd -d wine && \
adduser wine sudo

# SELECTION DE L'UTILISATEUR
USER wine

# SELECTION DE L'ESPACE DE TRAVAIL
WORKDIR /home/wine/

# AJOUT DU REPOS ET DE LA CLEF GPG
RUN sudo dpkg --add-architecture i386 && \
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add - && \
sudo apt-add-repository https://dl.winehq.org/wine-builds/debian/

# INSTALLATION DE L'APPLICATION
RUN sudo apt-get update && sudo apt-get install -y \
winehq-stable && \
export PATH=$PATH:/opt/wine-stable/bin

# NETTOYAGE
RUN sudo apt-get --purge autoremove -y \
wget
software-properties-common \
apt-transport-https \
gnupg && \
sudo apt-get autoclean -y && \
sudo rm /etc/apt/sources.list && \
sudo rm -rf /var/cache/apt/archives/* && \
sudo rm -rf /var/lib/apt/lists/*

# COMMANDE AU DEMARRAGE DU CONTENEUR
CMD /bin/bash
