#!/bin/bash
set -xeuo pipefail
cd /
#genkernel --lvm --ramdisk-modules initramfs
genkernel --ramdisk-modules initramfs
exit 0
