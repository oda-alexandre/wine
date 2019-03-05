FROM debian:stretch-slim

MAINTAINER https://oda-alexandre.com

# VARIABLES
ENV USER wine \
LANG fr_FR.UTF-8

# INSTALLATION DES PREREQUIS
RUN apt-get update && apt-get install -y --no-install-recommends \
sudo \
locales \
ca-certificates \
software-properties-common \
apt-transport-https \
gnupg \
wget && \

# SELECTION DE LA LANGUE FRANCAISE
echo ${LANG} > /etc/locale.gen && locale-gen && \

# AJOUT UTILISATEUR
useradd -d /home/${USER} -m ${USER} && \
passwd -d ${USER} && \
adduser ${USER} sudo

# SELECTION UTILISATEUR
USER ${USER}

# SELECTION ESPACE DE TRAVAIL
WORKDIR /home/${USER}

# AJOUT DU REPOS ET DE LA CLEF GPG
RUN sudo dpkg --add-architecture i386 && \
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add - && \
sudo apt-add-repository https://dl.winehq.org/wine-builds/debian/ && \

# INSTALLATION DE L'APPLICATION
sudo apt-get update && sudo apt-get install -y \
winehq-stable && \
export PATH=$PATH:/opt/wine-stable/bin && \

# NETTOYAGE
sudo apt-get --purge autoremove -y \
wget \
software-properties-common \
apt-transport-https \
gnupg && \
sudo apt-get autoclean -y && \
sudo rm /etc/apt/sources.list && \
sudo rm -rf /var/cache/apt/archives/* && \
sudo rm -rf /var/lib/apt/lists/*

# COMMANDE AU DEMARRAGE DU CONTENEUR
CMD /bin/bash
