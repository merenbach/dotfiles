#! /bin/sh -x

MY_USER=andrew

pw group mod wheel -m "${MY_USER}"
pw group mod operator -m "${MY_USER}"
pw group mod video -m "${MY_USER}"

#[TODO] /etc/make.conf
pkg bootstrap
pkg install -y security/ca_root_nss
#/usr/bin/svnlite checkout -r HEAD https://svn.freebsd.org/ports/head /usr/ports
portsnap fetch update || portsnap extract && /usr/bin/make -C /usr/ports fetchindex


sysrc zfs_enable="YES"
service zfs start
# zpool create wasteland /dev/ada...
# zfs create wasteland/arroyo
# zfs set compression=lz4 wasteland/arroyo
# zfs set mountpoint=/usr/home wasteland/arroyo
# ### only with enough space: zfs set copies=2 wasteland/arroyo
# ### only with second drive: // setup zfs mirroring

# enable Linuxulator
sysrc linux_enable="YES"
kldload linux

# video and desktop
pkg install -y x11/xorg
pkg install -y x11/nvidia-driver x11/nvidia-settings x11/nvidia-xconfig
sysrc kld_list+="nvidia nvidia-modeset"
kldload nvidia
kldload nvidia-modeset
nvidia-xconfig --add-argb-glx-visuals --composite --depth=24
pkg install -y x11-wm/compton
pkg install -y x11/arandr

# login
#pkg install -y x11/xdm
#sed -i'-dist' '/^ttyv8/s/off/on /' /etc/ttys

##[TODO]
## rip discs like `ddrescue -n -b 2048 /dev/cd0 /path/to/out.iso /path/to/out.log`
## pre-mount with `mdconfig -a -t vnode -f /path/to/my.iso`
## mount with `mount -t cd9660 -o ro /dev/mdX /path/to/mount/point`
##pkg install -y sysutils/ddrescue


# desktop support
pkg install -y devel/dbus
sysrc dbus_enable="YES"
service dbus start

# desktop environment
pkg install -y x11-wm/fvwm2
pkg install -y x11/xload
pkg install -y x11-clocks/xclock

# smartmontools
pkg install -y sysutils/smartmontools
cp -i /usr/local/etc/smartd.conf.sample /usr/local/etc/smartd.conf
sysrc smartd_enable="YES"
service smartd start

# track CPU microcode updates
pkg install -y sysutils/devcpu-data
sysrc microcode_update_enable="YES"
# may be redundant since enabling seems to run 
service microcode_update start

# sensors
sysrc kld_list+="coretemp"
#sysrc kld_list+="amdtemp"

# security
sysrc syslogd_flags="-ss"
sysrc sshd_enable="NO"
service sshd stop
sysrc firewall_type="workstation"
sysrc firewall_quiet="YES"
#sysrc firewall_myservices="ssh"
#sysrc firewall_allowservices="any"
sysrc firewall_logdeny="YES"
sysrc ipfw_enable="YES"
service ipfw start

# fonts
pkg install -y x11-fonts/dina
pkg install -y x11-fonts/droid-fonts-ttf
pkg install -y x11-fonts/freefont-ttf
pkg install -y x11-fonts/gnu-unifont
pkg install -y x11-fonts/terminus-font
pkg install -y x11-fonts/urwfonts
pkg install -y x11-fonts/webfonts
#pkg install -y x11-fonts/xorg-fonts


# program launching
pkg install -y x11/dmenu
pkg install -y x11/xbindkeys

# disable moused
#sysrc moused_enable="NO"

# ntp
sysrc ntpd_enable="YES"
sysrc ntpd_sync_on_start="YES"
service ntpd start

pkg install -y shells/bash
#pkg install -y shells/ksh93
#[TODO] disable crash dumps
#sysrc dumpdev="NO"
# [TODO]use ksh???
#append_if_absent /etc/sysctl.conf 'hw.syscons.bell=0'
#append_if_absent /etc/sysctl.conf 'hw.snd.default_auto=0'
#append_if_absent /etc/sysctl.conf 'hw.snd.default_unit=3'
#append_if_absent /etc/sysctl.conf 'kern.coredump=0'
##??#append_if_absent /etc/sysctl.conf 'vfs.usermount=1'
#append_if_absent /boot/loader.conf 'autoboot_delay="2"'
#append_if_absent /boot/loader.conf 'loader_logo="beastie"'
sysrc clear_tmp_enable="YES"

#[TODO] ensure Qt has enough shared memory to avoid glitches
#append_if_absent /boot/loader.conf 'kern.ipc.shmseg=1024'
#append_if_absent /boot/loader.conf 'kern.ipc.shmmni=1024'

# disks
sysrc fsck_y_enable="YES"

## samba
#pkg install -y net/samba46
#touch /usr/local/etc/smb4.conf

# [TODO] automount
sysrc autofs_enable="YES"
# see more here: https://www.freebsd.org/doc/handbook/usb-disks.html

ln -s /net/sulik/volume1 /media/sulik

# screen locking
pkg install -y x11/slock
#pkg install -y x11/xlockmore
#pkg install -y x11/xautolock

# misc utils
pkg install -y sysutils/pwgen
pkg install -y net/rclone
pkg install -y net/rsync
pkg install -y security/keepassx2
pkg install -y textproc/the_silver_searcher
pkg install -y textproc/dict
pkg install -y graphics/feh
pkg install -y x11/xclip
pkg install -y security/nmap
#pkg install -y security/keychain
pkg install -y sysutils/lsof
#[TODO]pkg install -y sysutils/cmdwatch
pkg install -y net-mgmt/whatmask
pkg install -y math/calc
pkg install -y ftp/curl
pkg install -y ftp/wget
pkg install -y archivers/zip
pkg install -y archivers/unzip
pkg install -y net-p2p/rtorrent
pkg install -y devel/awscli
#[TODO] deskutils/zim
#[TODO] graphics/epdfview
#[TODO]pkg install -y graphics/GraphicsMagick # screenshots, conversions, etc.

# pkg install -y net/wireshark
# // add to group if necessary

# productivity
pkg install -y editors/libreoffice
pkg install -y editors/texmaker
#pkg install -y editors/vim
pkg install -y graphics/gimp
pkg install -y print/texlive-full
pkg install -y textproc/hs-pandoc
pkg install -y www/firefox
# [TODO] pkg install -y www/chromium
# [TODO] sysctl kern.ipc.shm_allow_removed=1
pkg install -y multimedia/mpv
pkg install -y multimedia/vlc
pkg install -y graphics/xpdf
pkg install -y audio/clementine-player

pkg install -y audio/exaile
pkg install -y audio/gstreamer-plugins-mp3
# libdvdcss?
pkg install -y graphics/geeqie
#[TODO]pkg install -y multimedia/quodlibet
#[TODO]pkg install -y x11/rxvt-unicode
#[TODO]pkg install -y x11/urxvt-perls
#[TODO]pkg install -y www/chromium
# security/pinentry, password-store
# 

#[TODO]/usr/bin/make -C /usr/ports/x11-fonts/webfonts install clean BATCH=YES

# coding
pkg install -y devel/git
pkg install -y editors/emacs
pkg install -y lang/python3
pkg install -y lang/racket-minimal
pkg install -y misc/sloccount
#[TODO] pkg install -y devel/diffuse
#[TODO]pkg install -y sysutils/tmux
#[TODO]pkg install -y www/httpie
#[TODO]pkg install -y www/lynx

# graphical control for SMART
pkg install -y sysutils/gsmartcontrol
#cp /usr/local/share/examples/libgnomesu/gnomesu-pam.sample /usr/local/etc/pam.d/gnomesu-pam

# misc, more optional
pkg install -y security/openssh-askpass
#[TODO] pkg install -y science/gramps
#[TODO] pkg install -y misc/lifelines
#[TODO] pkg install -y deskutils/gucharmap
#[TODO] pkg install -y deskutils/gourmet

# virtualization
pkg install -y emulators/virtualbox-ose
pw group mod vboxusers -m "${MY_USER}"
sysrc kld_list+="vboxdrv"
sysrc vboxnet_enable="YES"
kldload vboxdrv
service vboxnet start

# gaming
pkg install -y emulators/dosbox
pkg install -y emulators/playonbsd
pkg install -y emulators/i386-wine-devel emulators/winetricks
#[TODO] pkg install -y emulators/wine-gecko emulators/wine-mono-devel
#winetricks install gdiplus
#winetricks install dotnet40
/bin/sh /usr/local/share/wine/patch-nvidia.sh

pkg install -y games/alephone games/alephone-data
pkg install -y games/angband
#[TODO]pkg install -y games/zangband
#[TODO]pkg install -y games/nethack
#[TODO]pkg install -y games/doomsday
#[TODO] pkg install -y games/xboard (may need custom flags)
# [TODO] pkg install -y games/alephone-scenarios (need to change flags for Tempus)
pkg install -y games/scummvm games/scummvm-tools
# [TODO] scummvm-tools requires lame
# [TODO] fallout install: f2_res.ini GRAPHICS_MODE=2 and UAC_AWARE=0
# chmod 444 [dD]ata/[pP]roto/[iI]tems/* [dD]ata/[pP]roto/[cC]ritters/*
# can also create dedicated root--see old
# 
# - name: ensure game starts in Arroyo village
#   ini_file:
#     dest: "{{ fallout2.full_path }}/ddraw.ini"
#     section: Misc
#     option: StartingMap
#     value: ARVILLAG.MAP
#     backup: yes
#   tags: configuration

# - name: ensure wine root is present
#   file: path="{{ local_home }}/wine" state=directory
#   tags: configuration

# - name: ensure wine prefix is present
#   command: /usr/bin/env WINEARCH=win32 WINEPREFIX="{{ wine_prefix }}" wineboot creates="{{ wine_prefix }}"
#   tags: configuration

# # Note that this step can be done by simply copying the base game folder, too
# # It is not GOG-dependent
# - name: ensure game is installed
#   command: /usr/bin/env WINEPREFIX="{{ wine_prefix }}" wine "{{ fallout2.setup_exe }}" creates="{{ fallout2.full_path }}"
#   tags: configuration

# - name: ensure game patch is installed
#   command: /usr/bin/env WINEPREFIX="{{ wine_prefix }}" wine "{{ fallout2.patch_exe }}" creates="{{ fallout2.full_path }}/fallout2.cfg_orig"
#   tags: configuration


# XFCE
pkg install -y x11-wm/xfce4
pkg install -y misc/xfce4-wm-themes
pkg install -y audio/xfce4-mixer
pkg install -y x11/xfce4-screenshooter-plugin
pkg install -y x11/xfce4-whiskermenu-plugin
pkg install -y misc/xfce4-weather-plugin
pkg install -y archivers/thunar-archive-plugin
pkg install -y archivers/xarchiver
# KDE
# pkg install -y x11/kde4
# sysrc hald_enable="YES"
# sysrc dbus_enable="YES"
# sysrc kdm4_enable="YES"
# pkg install -y databases/virtuoso
#cp /usr/local/lib/virtuoso/db/virtuoso.ini.sample /usr/local/lib/virtuoso/db/virtuoso.ini
#echo 'proc           /proc       procfs  rw  0   0' >> /etc/fstab



pkg install -y i3 i3status i3lock
