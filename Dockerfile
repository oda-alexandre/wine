# IMAGE TO USE
FROM debian:stretch-slim

# MAINTAINER
MAINTAINER http://www.oda-alexandre.com/

# VARIABLES
ENV USER wine
ENV LANG fr_FR.UTF-8

# INSTALL PACKAGES
RUN apt-get update && apt-get install -y --no-install-recommends \
sudo \
locales \
ca-certificates \
software-properties-common \
apt-transport-https \
gnupg \
wget && \

# CHANGE LOCALES
echo ${LANG} > /etc/locale.gen && locale-gen && \

# ADD USER
useradd -d /home/${USER} -m ${USER} && \
passwd -d ${USER} && \
adduser ${USER} sudo

# SELECT USER
USER ${USER}

# SELECT WORKING SPACE
WORKDIR /home/${USER}

# ADD OF REPOS AND OF THE KEY GPG
RUN sudo dpkg --add-architecture i386 && \
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add - && \
sudo apt-add-repository https://dl.winehq.org/wine-builds/debian/ && \

# INSTALL APP
sudo apt-get update && sudo apt-get install -y \
winehq-stable && \
export PATH=$PATH:/opt/wine-stable/bin && \

# CLEANING
sudo apt-get --purge autoremove -y \
wget \
software-properties-common \
apt-transport-https \
gnupg && \
sudo apt-get autoclean -y && \
sudo rm /etc/apt/sources.list && \
sudo rm -rf /var/cache/apt/archives/* && \
sudo rm -rf /var/lib/apt/lists/*

# START THE CONTAINER
CMD /bin/bash \
