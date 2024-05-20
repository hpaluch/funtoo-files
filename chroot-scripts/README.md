# Chroot scripts template.

I simply put all these chroot scripts into Hosts chroot with Gentoo/Funtoo
(for example into /srv/funtoo/funtoo-srv/ on Build Server). Then I have to:

1. Once after boot of Host OS bind mount directories using: `./bind_mounts.sh`. This
   one is specific for Azure VM where is additional local storage mounted under `/mnt`. This
   script will remount it into `/var/tmp/` of Gentoo target for quicker building with lot
   of storage available for build. There also exists simple variant `./bind_mounts_bare_metal.sh` which
   just do bind mounts but without any action on `/mnt/`
2. Then every time I want enter chroot I run `./enter_chroot.sh`
3. Finall (now under active chroot) I invoke `source /init_profile.sh`
   to get nice prompt that indicate that I'm in chroot

Reboot note: When host OS uses systemd I have troubles trying to unbind these mounts - I rather
reboot host OS.
