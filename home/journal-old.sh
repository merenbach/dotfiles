#! /bin/sh -x


MY_USER=andrew

pw group mod wheel -m "${MY_USER}"
pw group mod operator -m "${MY_USER}"
pw group mod video -m "${MY_USER}"


install() {
	# replace with manual compile later...
	#pkg install -y "$@"
	/usr/local/sbin/portmaster --no-confirm -B -G -D "$@"
}

WHICH_MAKE=/usr/bin/make
#WHICH_PORTSNAP=...

#[TODO] /etc/make.conf
# https://chriswells.io/blog/using-quarterly-ports-on-freebsd
/usr/bin/svnlite checkout https://svn.freebsd.org/ports/branches/2018Q2 /usr/ports
# when it's time to update...
# /usr/bin/svnlite switch https://svn.freebsd.org/ports/branches/20YYQN... /usr/ports
# /usr/bin/svnlite update /usr/ports
#
# or, for the latest and greatest (and possibly broken)...
#/usr/bin/svnlite checkout -r HEAD https://svn.freebsd.org/ports/head /usr/ports

# install portmaster
/usr/bin/make -C /usr/ports/ports-mgmt/portmaster install clean BATCH=yes

pkg bootstrap

# since pkgs are quarterly, and svn defaults to HEAD, we can also choose a different branch if we prefer
#portsnap fetch update || portsnap extract && ${WHICH_MAKE} -C /usr/ports fetchindex

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
MY_INSTALL x11-wm/bspwm
MY_INSTALL x11/sxhkd
MY_INSTALL x11/xload
MY_INSTALL x11-clocks/xclock

# screen locking

# security
sysrc syslogd_flags="-ss"
sysrc sshd_enable="NO"
service sshd stop

# fonts
install_fonts() {
	MY_INSTALL x11-fonts/dina
	MY_INSTALL x11-fonts/droid-fonts-ttf
	MY_INSTALL x11-fonts/freefont-ttf
	MY_INSTALL x11-fonts/gnu-unifont
	MY_INSTALL x11-fonts/terminus-font
	MY_INSTALL x11-fonts/urwfonts
	MY_INSTALL x11-fonts/webfonts
	MY_INSTALL x11-fonts/xorg-fonts
}
install_fonts()

# program launching
#MY_INSTALL x11/xbindkeys

# disable moused
#sysrc moused_enable="NO"

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

## samba
#MY_INSTALL net/samba46
#touch /usr/local/etc/smb4.conf

# [TODO] automount
sysrc autofs_enable="YES"
# see more here: https://www.freebsd.org/doc/handbook/usb-disks.html

ln -s /net/sulik/volume1 /media/sulik


# misc utils
#MY_INSTALL x11/xclip
#MY_INSTALL security/keychain
MY_INSTALL sysutils/lsof
#[TODO]MY_INSTALL sysutils/cmdwatch
#MY_INSTALL net-p2p/rtorrent
#[TODO] deskutils/zim
#[TODO] graphics/epdfview
#[TODO]MY_INSTALL graphics/GraphicsMagick # screenshots, conversions, etc.

# MY_INSTALL net/wireshark
# // add to group if necessary

# productivity
MY_INSTALL multimedia/mpv
MY_INSTALL multimedia/vlc
MY_INSTALL audio/clementine-player

MY_INSTALL audio/exaile
MY_INSTALL audio/gstreamer-plugins-mp3
# libdvdcss?
MY_INSTALL graphics/geeqie
#[TODO]MY_INSTALL multimedia/quodlibet
#[TODO]MY_INSTALL www/chromium
# security/pinentry, password-store
# 

#[TODO]${WHICH_MAKE} -C /usr/ports/x11-fonts/webfonts install clean BATCH=YES

# coding
#[TODO] MY_INSTALL devel/diffuse
#[TODO]MY_INSTALL www/httpie
#[TODO]MY_INSTALL www/lynx

# graphical control for SMART
#MY_INSTALL sysutils/gsmartcontrol
#cp /usr/local/share/examples/libgnomesu/gnomesu-pam.sample /usr/local/etc/pam.d/gnomesu-pam

# misc, more optional
MY_INSTALL security/openssh-askpass
#[TODO] MY_INSTALL science/gramps
#[TODO] MY_INSTALL misc/lifelines
#[TODO] MY_INSTALL deskutils/gucharmap
#[TODO] MY_INSTALL deskutils/gourmet

# gaming emulators
#winetricks install gdiplus
#winetricks install dotnet40
#MY_INSTALL emulators/playonbsd

# TODO: TEXT ADVENTURES
#[TODO]MY_INSTALL games/zangband
#[TODO]MY_INSTALL games/nethack
#[TODO]MY_INSTALL games/doomsday
#[TODO] MY_INSTALL games/xboard (may need custom flags)

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


# virtualization
pw group mod vboxusers -m "${MY_USER}"
sysrc kld_list+="vboxdrv"
sysrc vboxnet_enable="YES"
kldload vboxdrv
service vboxnet start
