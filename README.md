# WINE

![logo](https://assets.gitlab-static.net/uploads/-/system/project/avatar/12904491/wine-logo.png)

- [WINE](#wine)
  - [INDEX](#index)
  - [BADGES](#badges)
  - [INTRODUCTION](#introduction)
  - [PREREQUISITES](#prerequisites)
  - [INSTALL](#install)
    - [DOCKER RUN](#docker-run)
    - [DOCKER COMPOSE](#docker-compose)
  - [LICENSE](#license)

## BADGES

[![pipeline status](https://gitlab.com/oda-alexandre/wine/badges/master/pipeline.svg)](https://gitlab.com/oda-alexandre/wine/commits/master)

## INTRODUCTION

Docker image of :

- [wine](https://www.winehq.org)

Continuous integration on :

- [gitlab pipelines](https://gitlab.com/oda-alexandre/wine/pipelines)

Automatically updated on :

- [docker hub public](https://hub.docker.com/r/alexandreoda/wine/)

## PREREQUISITES

Use [docker](https://www.docker.com)

## BUILD

### DOCKER RUN

```\
docker run --rm -ti \
--name wine \
--group-add audio \
--device /dev/snd \
-e DISPLAY \
-e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
-v ${HOME}:/home/wine \
-v /tmp/.X11-unix/:/tmp/.X11-unix/ \
-v /dev/shm:/dev/shm \
-v /var/run/dbus:/var/run/dbus \
-v /etc/localtime:/etc/localtime:ro \
-v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native \
alexandreoda/wine
```

### DOCKER COMPOSE

```yml
version: "2.0"

services:
  wine:
    container_name: wine
    image: alexandreoda/wine
    restart: "no"
    privileged: false
    devices:
      - /dev/snd
    environment:
      - DISPLAY
      - PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native
    volumes:
      - "${HOME}:/home/wine"
      - "/tmp/.X11-unix/:/tmp/.X11-unix/"
      - "/dev/shm:/dev/shm"
      - "/var/run/dbus:/var/run/dbus"
      - "/etc/localtime:/etc/localtime:ro"
      - "${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native"
```

## LICENSE

[![GPLv3+](http://gplv3.fsf.org/gplv3-127x51.png)](https://gitlab.com/oda-alexandre/wine/blob/master/LICENSE)
