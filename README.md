# WINE

<img src="https://mintguide.org/uploads/posts/2016-01/1453119587_winehq-logo1-300x173.png" width="200" height="200"/>

## INDEX

- [Badges](#BADGES)
- [Introduction](#INTRODUCTION)
- [Prerequisites](#PREREQUISITESITES)
- [Install](#INSTALL)
- [License](#LICENSE)


## BADGES

[![pipeline status](https://gitlab.com/oda-alexandre/wine/badges/master/pipeline.svg)](https://gitlab.com/oda-alexandre/wine/commits/master)


## INTRODUCTION

Docker image of :

- [wine](https://www.winehq.org)

Continuous integration on :

- [gitlab](https://gitlab.com/oda-alexandre/wine/pipelines)

Automatically updated on :

- [docker hub public](https://hub.docker.com/r/alexandreoda/wine/)


## PREREQUISITES

Use [docker](https://www.docker.com)


## INSTALL

```
docker run --rm -ti --name wine -v ${HOME}:/home/wine -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v /dev/snd:/dev/snd -v /dev/shm:/dev/shm -v /var/run/dbus:/var/run/dbus -v /etc/localtime:/etc/localtime:ro -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native --group-add $(getent group audio | cut -d: -f3) -e DISPLAY alexandreoda/wine
```


## LICENSE

[![GPLv3+](http://gplv3.fsf.org/gplv3-127x51.png)](https://gitlab.com/oda-alexandre/wine/blob/master/LICENSE)
