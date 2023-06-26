#!/bin/bash

#   Copyright (C) 2023 Diego Roux
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <https://www.gnu.org/licenses/>.

# We really don't need the history.
git clone --depth=1 --branch $BRANCH https://github.com/raspberrypi/linux kernel-$BRANCH

cd kernel-$BRANCH/

# We need to make sure that we're building on a clean tree.
make mrproper

## TODO: build instructions for all RPi's.
# Build instructions for Raspberry Pi 1, Zero and Zero W, and Raspberry Pi Compute Module 1.
export KERNEL=kernel
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcmrpi_defconfig

# Enable SELinux
./scripts/config -e CONFIG_SECURITY
./scripts/config -e CONFIG_SECURITY_SELINUX
./scripts/config -e CONFIG_AUDIT

# Set a "tag" that we can recognize when we run uname.
./scripts/config --set-str CONFIG_LOCALVERSION "-se-rpi"

# Compile the kernel.
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs

export SEPATH=/etc/se-raspbian/

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=$SEPATH modules_install

mkdir -p $SEPATH/boot
mkdir -p $SEPATH/boot/overlays

# Copy what RPi needs to boot.
cp arch/arm/boot/zImage $SEPATH/boot/$KERNEL.img
cp arch/arm/boot/dts/*.dtb $SEPATH/boot/
cp arch/arm/boot/dts/overlays/*.dtb* $SEPATH/boot/overlays/
cp arch/arm/boot/dts/overlays/README $SEPATH/boot/overlays/