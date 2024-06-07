#!/bin/bash
set -xeuo pipefail
cd /
# genkernel no longer availble (lvm version conflict)
# magic=ahci,sd_mod param requires fix from https://code.funtoo.org/bitbucket/users/manatwork/repos/funtoo-ramdisk/commits/d036b81a1f7eaa909feec96e8cb5e4c6a9836e02#funtoo_ramdisk/support/linuxrc
ramdisk list kernels
k=4.19.314-hpnv;ramdisk build --kernel $k --kpop=ahci,sd_mod /tmp/initramfs-$k && cp /tmp/initramfs-$k /boot
exit 0
