# se-raspbian (WIP)
Dockerfile to compile the Raspberry Linux Kernel with SELinux enabled.

## Note
As of right now, we only target Raspberry Pi 1, Zero and Zero W, and Raspberry Pi Compute Module 1, there are plans to target all RPi's.

## Download
```$ docker pull diegoroux04/se-raspbian:latest```

## Quick Start
```
$ docker run d \
    --name se-raspbian \
    -v /path/to/store/kernel/se-raspbian:/etc/se-raspbian/ \
    -e BRANCH="rpi-6.1.y" \
    diegoroux04/se-raspbian
```