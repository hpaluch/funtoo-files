#!/bin/bash
set -xeuo pipefail
cd /
#genkernel --lvm --ramdisk-modules initramfs
#genkernel --ramdisk-modules initramfs
ramdisk list kernels
k=6.9.3-vanilla-hpfunsrv;ramdisk build --kernel $k --kpop=ahci,sd_mod /tmp/initramfs-$k && cp /tmp/initramfs-$k /boot
exit 0
