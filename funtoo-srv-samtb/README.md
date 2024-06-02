# funtoo-srv-samtb

Here are configuration files for my bare-metal machine (AMD Opteron X2) on ext4.
It is "server like" workload (core profile).

Decoding hostname `funtoo-srv-samtb`:
- `funtoo` (obvious)
- `srv` - server workload
- `samtb` - Samsung 1TB (SSD) disk

To see additional installed packages please look at:
- [var/lib/portage/world](var/lib/portage/world)

# Updates

As of 2 Jun, 2024 I have to remove `genkernel` and use `sys-apps/ramdisk` (Funtoo specific
tool to create initramfs). However it does not properly proces `magic=module1,module2,...` boot
parameter. Reported bug and proposed fix here:
- https://bugs.funtoo.org/browse/FL-12408?filter=-2

Resources regarding installed packages:
- https://www.funtoo.org/Package:Nftables
- https://www.funtoo.org/Package:MediaWiki
  - not actually installed but I used `rc-update add metalog default` from there...
