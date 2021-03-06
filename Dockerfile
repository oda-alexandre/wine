FROM debian:stretch-slim

LABEL authors https://www.oda-alexandre.com

ENV USER wine
ENV HOME /home/${USER}

RUN echo -e '\033[36;1m ******* INSTALL PACKAGES ******** \033[0m' && \
  apt-get update && apt-get install -y --no-install-recommends \
  sudo \
  ca-certificates \
  software-properties-common \
  apt-transport-https \
  gnupg \
  wget  && \
  rm -rf /var/lib/apt/lists/*

RUN echo -e '\033[36;1m ******* ADD SOURCE APP & KEY GPG ******** \033[0m' && \
  sudo dpkg --add-architecture i386 && \
  wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add - && \
  sudo apt-add-repository https://dl.winehq.org/wine-builds/debian/ && \
  sudo apt-get --purge autoremove -y wget
  
RUN echo -e '\033[36;1m ******* INSTALL APP ******** \033[0m' && \
  sudo apt-get update && sudo apt-get install -y \
  winehq-stable && \
  export PATH=$PATH:/opt/wine-stable/bin && \
  rm -rf /var/lib/apt/lists/*

RUN echo -e '\033[36;1m ******* ADD USER ******** \033[0m' && \
  useradd -d ${HOME} -m ${USER} && \
  passwd -d ${USER} && \
  adduser ${USER} sudo

RUN echo -e '\033[36;1m ******* SELECT USER ******** \033[0m'
USER ${USER}

RUN echo -e '\033[36;1m ******* SELECT WORKING SPACE ******** \033[0m'
WORKDIR ${HOME}

RUN echo -e '\033[36;1m ******* CONTAINER START COMMAND ******** \033[0m'
CMD /bin/bash \