#! /bin/sh -x

MY_USER=andrew

pw group mod wheel -m "${MY_USER}"
pw group mod operator -m "${MY_USER}"
pw group mod video -m "${MY_USER}"


install() {
	# replace with manual compile later...
	pkg install -y "$@"
}

WHICH_MAKE=/usr/bin/make
#WHICH_PORTSNAP=...

#[TODO] /etc/make.conf
pkg bootstrap
MY_INSTALL security/ca_root_nss
#/usr/bin/svnlite checkout -r HEAD https://svn.freebsd.org/ports/head /usr/ports
portsnap fetch update || portsnap extract && ${WHICH_MAKE} -C /usr/ports fetchindex

zfs() {
	sysrc zfs_enable="YES"
	service zfs start
	# zpool create wasteland /dev/ada...
	# zfs create wasteland/arroyo
	# zfs set compression=lz4 wasteland/arroyo
	# zfs set mountpoint=/usr/home wasteland/arroyo
	# ### only with enough space: zfs set copies=2 wasteland/arroyo
	# ### only with second drive: // setup zfs mirroring
}

zfs()

# enable Linuxulator
sysrc linux_enable="YES"
kldload linux

# video and desktop
MY_INSTALL x11/xorg
MY_INSTALL x11/nvidia-driver x11/nvidia-settings x11/nvidia-xconfig
sysrc kld_list+="nvidia nvidia-modeset"
kldload nvidia
kldload nvidia-modeset
nvidia-xconfig --add-argb-glx-visuals --composite --depth=24
MY_INSTALL x11-wm/compton
MY_INSTALL x11/arandr

# login
#MY_INSTALL x11/xdm
#sed -i'-dist' '/^ttyv8/s/off/on /' /etc/ttys

##[TODO]
## rip discs like `ddrescue -n -b 2048 /dev/cd0 /path/to/out.iso /path/to/out.log`
## pre-mount with `mdconfig -a -t vnode -f /path/to/my.iso`
## mount with `mount -t cd9660 -o ro /dev/mdX /path/to/mount/point`
##MY_INSTALL sysutils/ddrescue


# desktop support
MY_INSTALL devel/dbus
sysrc dbus_enable="YES"
service dbus start

# desktop environment
MY_INSTALL x11/rofi
MY_INSTALL x11-wm/bspwm
#MY_INSTALL x11-wm/sxhkd
#MY_INSTALL x11-wm/fvwm2
MY_INSTALL x11/xload
MY_INSTALL x11-clocks/xclock

# screen locking
MY_INSTALL x11/xautolock
MY_INSTALL x11/xlockmore

smartmontools() {
	# smartmontools
	MY_INSTALL sysutils/smartmontools
	cp -i /usr/local/etc/smartd.conf.sample /usr/local/etc/smartd.conf
	sysrc smartd_enable="YES"
	service smartd start
}

microcode() {
	# track CPU microcode updates
	MY_INSTALL sysutils/devcpu-data
	sysrc microcode_update_enable="YES"
	# may be redundant since enabling seems to run
	service microcode_update start
}

smartmontools()
microcode()

# sensors
sysrc kld_list+="coretemp"
#sysrc kld_list+="amdtemp"

# security
sysrc syslogd_flags="-ss"
sysrc sshd_enable="NO"
service sshd stop

firewall() {
	sysrc firewall_type="workstation"
	sysrc firewall_quiet="YES"
	#sysrc firewall_myservices="ssh"
	#sysrc firewall_allowservices="any"
	sysrc firewall_logdeny="YES"
	sysrc ipfw_enable="YES"
	service ipfw start
}
firewall()

# fonts
MY_INSTALL x11-fonts/dina
MY_INSTALL x11-fonts/droid-fonts-ttf
MY_INSTALL x11-fonts/freefont-ttf
MY_INSTALL x11-fonts/gnu-unifont
MY_INSTALL x11-fonts/terminus-font
MY_INSTALL x11-fonts/urwfonts
MY_INSTALL x11-fonts/webfonts
#MY_INSTALL x11-fonts/xorg-fonts


# program launching
#MY_INSTALL x11/xbindkeys

# disable moused
#sysrc moused_enable="NO"

ntp() {
	# ntp
	sysrc ntpd_enable="YES"
	sysrc ntpd_sync_on_start="YES"
	service ntpd onefetch
	service ntpd start
}
ntp()

MY_INSTALL shells/bash
#MY_INSTALL shells/ksh93
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
#MY_INSTALL net/samba46
#touch /usr/local/etc/smb4.conf

# [TODO] automount
sysrc autofs_enable="YES"
# see more here: https://www.freebsd.org/doc/handbook/usb-disks.html

ln -s /net/sulik/volume1 /media/sulik

# misc utils
MY_INSTALL sysutils/pwgen
MY_INSTALL net/rclone
MY_INSTALL net/rsync
MY_INSTALL security/keepassx2
MY_INSTALL textproc/the_silver_searcher
MY_INSTALL textproc/dict
MY_INSTALL graphics/feh
MY_INSTALL x11/xsel
#MY_INSTALL x11/xclip
MY_INSTALL security/nmap
#MY_INSTALL security/keychain
MY_INSTALL sysutils/lsof
#[TODO]MY_INSTALL sysutils/cmdwatch
MY_INSTALL net-mgmt/whatmask
MY_INSTALL math/calc
MY_INSTALL ftp/curl
MY_INSTALL ftp/wget
MY_INSTALL archivers/zip
MY_INSTALL archivers/unzip
MY_INSTALL net-p2p/rtorrent
MY_INSTALL devel/awscli
#[TODO] deskutils/zim
#[TODO] graphics/epdfview
#[TODO]MY_INSTALL graphics/GraphicsMagick # screenshots, conversions, etc.

# MY_INSTALL net/wireshark
# // add to group if necessary

# productivity
MY_INSTALL editors/libreoffice
MY_INSTALL editors/texmaker
MY_INSTALL graphics/gimp
MY_INSTALL print/texlive-full
MY_INSTALL textproc/hs-pandoc
MY_INSTALL www/firefox
# [TODO] MY_INSTALL www/chromium
# [TODO] sysctl kern.ipc.shm_allow_removed=1
MY_INSTALL multimedia/mpv
MY_INSTALL multimedia/vlc
MY_INSTALL graphics/xpdf
MY_INSTALL audio/clementine-player

MY_INSTALL audio/exaile
MY_INSTALL audio/gstreamer-plugins-mp3
# libdvdcss?
MY_INSTALL graphics/geeqie
#[TODO]MY_INSTALL multimedia/quodlibet
#[TODO]MY_INSTALL x11/rxvt-unicode
#[TODO]MY_INSTALL x11/urxvt-perls
#[TODO]MY_INSTALL www/chromium
# security/pinentry, password-store
# 

#[TODO]${WHICH_MAKE} -C /usr/ports/x11-fonts/webfonts install clean BATCH=YES

# coding
MY_INSTALL devel/git
MY_INSTALL editors/emacs
MY_INSTALL editors/vim
MY_INSTALL lang/go
MY_INSTALL lang/python3
MY_INSTALL lang/racket-minimal
MY_INSTALL misc/sloccount
#[TODO] MY_INSTALL devel/diffuse
#[TODO]MY_INSTALL sysutils/tmux
#[TODO]MY_INSTALL www/httpie
#[TODO]MY_INSTALL www/lynx

# graphical control for SMART
MY_INSTALL sysutils/gsmartcontrol
#cp /usr/local/share/examples/libgnomesu/gnomesu-pam.sample /usr/local/etc/pam.d/gnomesu-pam

# misc, more optional
MY_INSTALL security/openssh-askpass
#[TODO] MY_INSTALL science/gramps
#[TODO] MY_INSTALL misc/lifelines
#[TODO] MY_INSTALL deskutils/gucharmap
#[TODO] MY_INSTALL deskutils/gourmet

# virtualization
MY_INSTALL emulators/virtualbox-ose
pw group mod vboxusers -m "${MY_USER}"
sysrc kld_list+="vboxdrv"
sysrc vboxnet_enable="YES"
kldload vboxdrv
service vboxnet start

# gaming
MY_INSTALL emulators/dosbox
MY_INSTALL emulators/playonbsd
MY_INSTALL emulators/i386-wine-devel emulators/winetricks
#[TODO] MY_INSTALL emulators/wine-gecko emulators/wine-mono-devel
#winetricks install gdiplus
#winetricks install dotnet40
/bin/sh /usr/local/share/wine/patch-nvidia.sh

MY_INSTALL games/alephone games/alephone-data
MY_INSTALL games/angband
#[TODO]MY_INSTALL games/zangband
#[TODO]MY_INSTALL games/nethack
#[TODO]MY_INSTALL games/doomsday
#[TODO] MY_INSTALL games/xboard (may need custom flags)
# [TODO] MY_INSTALL games/alephone-scenarios (need to change flags for Tempus)
MY_INSTALL games/scummvm games/scummvm-tools
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
MY_INSTALL x11-wm/xfce4
MY_INSTALL misc/xfce4-wm-themes
MY_INSTALL audio/xfce4-mixer
MY_INSTALL x11/xfce4-screenshooter-plugin
MY_INSTALL x11/xfce4-whiskermenu-plugin
MY_INSTALL misc/xfce4-weather-plugin
MY_INSTALL archivers/thunar-archive-plugin
MY_INSTALL archivers/xarchiver
# KDE
# MY_INSTALL x11/kde4
# sysrc hald_enable="YES"
# sysrc dbus_enable="YES"
# sysrc kdm4_enable="YES"
# MY_INSTALL databases/virtuoso
#cp /usr/local/lib/virtuoso/db/virtuoso.ini.sample /usr/local/lib/virtuoso/db/virtuoso.ini
#echo 'proc           /proc       procfs  rw  0   0' >> /etc/fstab



