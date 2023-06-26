FROM ubuntu:22.04
MAINTAINER Diego Roux (@diegoroux04)

RUN apt-get update && apt -y -q upgrade && \
    apt-get -y -q install git bc bison flex \
    libssl-dev make libc6-dev libncurses5-dev \
    crossbuild-essential-armhf

RUN mkdir -p /etc/se-raspbian/

COPY make.sh ./

CMD ["bash", "make.sh"]