#!/bin/bash
set -xeuo pipefail
sed -i.bak -e  's/^\( *set *gfxpayload=keep.*\)/#\1/' /boot/grub/grub.cfg
exit 0
