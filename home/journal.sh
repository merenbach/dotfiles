#! /bin/sh

MY_USER=andrew

bootstrap() {
    for GROUP in wheel operator video;
    do
	pw group mod "${GROUP}" -m "${MY_USER}"
    done
    echo /dev/ada0p1     /usr/home       ufs     rw      1       1 >> /etc/fstab
    portsnap fetch extract
    freebsd-update fetch install
    /usr/bin/make -C /usr/ports/ports-mgmt/portmaster install clean BATCH=yes
    echo hw.snd.default_unit=3 >> /etc/sysctl.conf
}
#bootstrap()

# ideally copy /etc/make.conf into place before compiling

install() {
	#/usr/local/sbin/portmaster --no-confirm --update-if-newer -B -G -D "$@"

	# delete intermediate build dependencies installed as packages
	/usr/local/sbin/portmaster --no-confirm --packages-build --delete-build-only -B -G -D "$@"
}
enablemodule() {
	/usr/sbin/sysrc kld_list+="$1"
	/sbin/kldload "$1"
}
enableservice() {
	/usr/sbin/sysrc "$1_enable"="YES"
	/usr/sbin/service "$1" start
}

sysrc fsck_y_enable="YES"
sysrc clear_tmp_enable="YES"
sysrc syslogd_flags="-ss"
sysrc sendmail_enable="NONE"
sysrc dumpdev="NO"

# this might not be really necessary on a desktop
enableservice powerd

sysrc firewall_type="workstation"
sysrc firewall_quiet="YES"
#sysrc firewall_myservices="ssh"
#sysrc firewall_allowservices="any"
sysrc firewall_logdeny="YES"
enableservice ipfw

enablemodule coretemp
#enablemodule amdtemp

install "security/ca_root_nss"

# TODO: why do we do this again?
sysrc ntpd_sync_on_start="YES"
service ntpd onefetch
enableservice ntpd

install "x11/nvidia-driver"
enablemodule nvidia-modeset

install "devel/dbus"
enableservice dbus

install "sysutils/smartmontools"
cp -i /usr/local/etc/smartd.conf.sample /usr/local/etc/smartd.conf
enableservice smartd

install "sysutils/devcpu-data"
enableservice microcode_update

#TODO: is this necessary?
# enableservice devd

install "shells/bash" "shells/bash-completion"
chsh -s /usr/local/bin/bash "${MY_USER}"

##nvidia-xconfig --add-argb-glx-visuals --composite --depth=24
#cat <<EOF > /usr/local/etc/X11/xorg.conf.d/driver-nvidia.conf
#Section "Device"
#    Identifier     "Card0"
#    Driver         "nvidia"
#    VendorName     "NVIDIA Corporation"
##BusID "PCI:1:0:0"
#    #Option         "AccelMethod" "none"
#    #Option         "TripleBuffer" "True"
#    #Option         "MetaModes" "nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
#    ##Option         "MetaModes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
#EndSection
#EOF

install \
  "archivers/unzip" \
  "archivers/zip" \
  "devel/awscli" \
  "devel/git" \
  "devel/hs-cabal-install" \
  "editors/emacs" \
  "editors/libreoffice" \
  "editors/texmaker" \
  "editors/vim" \
  "emulators/dosbox" \
  "emulators/i386-wine-devel" \
  "emulators/wine-gecko-devel" \
  "emulators/wine-mono-devel" \
  "emulators/winetricks" \
  "ftp/curl" \
  "ftp/wget" \
  "games/alephone" \
  "games/alephone-data" \
  "games/alephone-scenarios" \
  "games/angband" \
  "games/lbreakout2" \
  "games/scummvm" \
  "games/scummvm-tools" \
  "games/sokoban" \
  "games/xmahjongg" \
  "games/xsokoban" \
  "graphics/feh" \
  "graphics/geeqie" \
  "graphics/gimp" \
  "graphics/xpdf" \
  "lang/gcc7" \
  "lang/ghc" \
  "lang/go" \
  "lang/python3" \
  "lang/racket-minimal" \
  "lang/rust" \
  "math/calc" \
  "misc/sloccount" \
  "multimedia/audacious" \
  "multimedia/audacious-plugins" \
  "multimedia/gstreamer-plugins-bad" \
  "multimedia/gstreamer-plugins-good" \
  "multimedia/gstreamer-plugins-ugly" \
  "multimedia/mpv" \
  "multimedia/smplayer" \
  "multimedia/vlc" \
  "net-mgmt/whatmask" \
  "net/rclone" \
  "net/rsync" \
  "print/texlive-full" \
  "security/keepassx2" \
  "security/nmap" \
  "sysutils/cmdwatch" \
  "sysutils/lsof" \
  "sysutils/pwgen" \
  "textproc/dict" \
  "textproc/hs-pandoc" \
  "textproc/jq" \
  "textproc/the_silver_searcher" \
  "www/chromium" \
  "www/firefox" \
  "x11-fm/pcmanfm" \
  "x11-fonts/dina" \
  "x11-fonts/droid-fonts-ttf" \
  "x11-fonts/freefont-ttf" \
  "x11-fonts/gnu-unifont" \
  "x11-fonts/terminus-font" \
  "x11-fonts/urwfonts" \
  "x11-fonts/webfonts" \
  "x11-fonts/xorg-fonts" \
  "x11-wm/compton" \
  "x11-wm/fvwm2" \
  "x11/arandr" \
  "x11/rofi" \
  "x11/rxvt-unicode" \
  "x11/urxvt-perls" \
  "x11/xautolock" \
  "x11/xlockmore" \
  "x11/xorg" \
  "x11/xsel"

# needed for i386-wine-devel on Nvidia cards
/bin/sh /usr/local/share/wine/patch-nvidia.sh

## not currently used
# install "devel/stack"
