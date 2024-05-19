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
