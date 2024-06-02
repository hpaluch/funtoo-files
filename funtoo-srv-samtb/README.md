# funtoo-srv-samtb

Here are configuration files for my bare-metal machine (AMD Opteron X2) on ext4.
It is "server like" workload (core profile).

Decoding hostname `funtoo-srv-samtb`:
- `funtoo` (obvious)
- `srv` - server workload
- `samtb` - Samsung 1TB (SSD) disk

To see additional installed packages please look at:
- [var/lib/portage/world](var/lib/portage/world)

Resources regarding installed packages:
- https://www.funtoo.org/Package:Nftables
- https://www.funtoo.org/Package:MediaWiki
  - not actually installed but I used `rc-update add metalog default` from there...

= ChangeLog

== 2024-06-01: genkernel conflicts

The `sys-kernel/genkernel` seems to be no longer supported - it requires lvm2 that
requires `udev` but only `eudev` is now there...

Trying:
```shell
# on Jun 1, 2024
ego sync
emerge -aC sys-kernel/genkernel
emerge -auDN @world
emerge -ac
# removed =sys-fs/lvm2-2.02.173 =sys-block/thin-provisioning-tools-0.8.5 \
# =sys-kernel/debian-sources-6.5.10_p1 =sys-fs/mdadm-4.1 =dev-libs/libaio-0.3.112 =sys-kernel/vanilla-sources-6.9.1
# building Debian official kernel
...
```
TODO: Clang 16 build fails, already reported:
- https://bugs.funtoo.org/browse/FL-12402

== 2024-06-02: Replaced sys-kernel/genkernel with sys-apps/ramdisk

I resolved above problems (lvm2 and genkernel errors) with  removal of
`genkernel` and using `sys-apps/ramdisk` (Funtoo specific tool to create
initramfs) instead. However it does not properly proces
`magic=module1,module2,...` boot parameter. Reported bug and proposed fix here:
- https://bugs.funtoo.org/browse/FL-12408?filter=-2


