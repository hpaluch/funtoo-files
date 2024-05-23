# Gentoo on nvidia GT218 (driver 340)

Here is my bumpy road how I got working nvidia GT218 under Gentoo.
Main tricky point is that only binary driver up to 340 is supported.

Partilly we may follow:
- https://www.funtoo.org/Package:NVIDIA_Linux_Display_Drivers
But some parts are outdated (`eselect opencl` and `eselect opengl` no longer works)...

Basic commands:
```shell
ego sync
ego profile mix-in gfxcard-nvidia-legacy
emerge -auDN @world
# now you need supported kernel - only version up to 4.20 are supported:
cd /usr/src/
curl -flO https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.314.tar.xz
tar xvf linux-4.19.314.tar.xz 
cd ~/back-to-this-project
# coy my config
x=usr/src/linux-4.19.314/arch/x86/configs/hpnv_defconfig
cp $x /$x
# build and install kernel
make -j`nproc`
make modules_install
make install
# before creating ramdisk you have to set link to kernel 4.19.314 sources:
eselect kernel list
eselect kernel set
genkernel --ramdisk-modules initramfs
# only then you can build drivers - watch for any errors
emerge -an x11-drivers/nvidia-drivers x11-drivers/nvidia-kernel-modules
# added xfce for debugging because it can run without OpenGL
emerge -an xfce-base/xfce4-meta
```

Here are my final profiles:
```shell
$ ego profile

=== Enabled Profiles: ===

        arch: x86-64bit
       build: next
     subarch: generic_64
      flavor: desktop
     mix-ins: gnome
     mix-ins: gfxcard-kvm
     mix-ins: gfxcard-amdgpu
     mix-ins: gfxcard-radeon
     mix-ins: gfxcard-vmware
     mix-ins: gfxcard-intel
     mix-ins: gfxcard-nvidia-legacy
     mix-ins: xfce

...
```

Most tricky stuff is getting to work OpenGL - because of libglx.so path collision (Xorg version
is normally loaded while nvidia version must be loaded).
- first you have to generate `/etc/X11/xorg.conf` using `/opt/nvidia/nvidia-drivers-340.108/bin/nvidia-xconfig`
- the VERY IMPORTANT - you have to prepend nvidia modules path before Xorg path by
  adding to `/etc/X11/xorg.conf`
  ```
  Section "Files"
          ModulePath "/opt/nvidia/nvidia-drivers-340.108/lib64/opengl/nvidia"
          ModulePath "/usr/lib64/xorg/modules"
  EndSection
  ```
- without that Xorg will load its ovn GLX module which will fail miserably
- this will have unwanted cascading effect that GDM manager will crash with fatal
  error because it requires OpenGL to work (new GNOME requirement)

Here is output of INXI when NVidia 340 driver is loaded properly:
```shell
# command below must be run from X11 GUI(!)

$ inxi -G --display

Graphics:
  Device-1: NVIDIA GT218 [GeForce 210] driver: nvidia v: 340.108
  Display: server: X.Org v: 1.20.10 driver: X: loaded: nvidia gpu: nvidia
    resolution: 1440x900~60Hz
  API: EGL v: 1.4 drivers: nvidia platforms: x11
  API: OpenGL v: 3.3.0 vendor: nvidia v: 340.108
    renderer: GeForce 210/PCIe/SSE2
```

TODO:
- ffmpeg is blocked entirely


