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

install "security/ca_root_nss"

# TODO: why do we do this again?
sysrc ntpd_sync_on_start="YES"
service ntpd onefetch
enableservice ntpd

install "x11/xorg"

enablemodule coretemp
#enablemodule amdtemp

install "x11/nvidia-driver"
enablemodule nvidia-modeset

install "devel/dbus"
enableservice dbus

install "sysutils/smartmontools"
cp -i /usr/local/etc/smartd.conf.sample /usr/local/etc/smartd.conf
enableservice smartd

sysrc firewall_type="workstation"
sysrc firewall_quiet="YES"
#sysrc firewall_myservices="ssh"
#sysrc firewall_allowservices="any"
sysrc firewall_logdeny="YES"
enableservice ipfw

install "sysutils/devcpu-data"
enableservice microcode_update

#TODO: is this necessary?
# enableservice devd

install "x11-wm/fvwm2"
install "x11-wm/compton"

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

install "x11/rofi"
install "x11/xlockmore"
install "x11/xautolock"


# utils
install "archivers/unzip"
  "archivers/zip" \
  "devel/awscli" \
  "ftp/curl" \
  "ftp/wget" \
  "graphics/feh" \
  "graphics/geeqie" \
  "math/calc" \
  "net-mgmt/whatmask" \
  "net/rclone" \
  "net/rsync" \
  "security/nmap" \
  "sysutils/cmdwatch" \
  "sysutils/lsof" \
  "sysutils/pwgen" \
  "textproc/dict" \
  "textproc/jq" \
  "textproc/the_silver_searcher" \
  "x11/arandr"

install "graphics/xpdf" \
  "security/keepassx2" \
  "x11-fm/pcmanfm" \
  "x11/rxvt-unicode" \
  "x11/urxvt-perls" \
  "x11/xsel"

install "editors/libreoffice" \
  "editors/texmaker" \
  "graphics/gimp" \
  "multimedia/audacious" \
  "multimedia/audacious-plugins" \
  "multimedia/gstreamer-plugins-bad" \
  "multimedia/gstreamer-plugins-good" \
  "multimedia/gstreamer-plugins-ugly" \
  "multimedia/mpv" \
  "multimedia/smplayer" \
  "multimedia/vlc" \
  "print/texlive-full" \
  "textproc/hs-pandoc" \
  "www/firefox" \
  "www/chromium"

install "devel/git" \
  "editors/vim" \
  "editors/emacs" \
  "lang/gcc7" \
  "lang/ghc" \
  "lang/go" \
  "lang/python3" \
  "lang/rust" \
  "lang/racket-minimal" \
  "misc/sloccount"

# install "devel/hs-cabal-install"
# install "devel/stack"

install "emulators/i386-wine-devel" \
  "emulators/wine-gecko-devel" \
  "emulators/wine-mono-devel" \
  "emulators/winetricks"
/bin/sh /usr/local/share/wine/patch-nvidia.sh

install "emulators/dosbox"

install "games/alephone" \
  "games/alephone-data" \
  "games/alephone-scenarios" \
  "games/angband" \
  "games/lbreakout2" \
  "games/scummvm" \
  "games/scummvm-tools" \
  "games/sokoban" \
  "games/xmahjongg" \
  "games/xsokoban"

install "x11-fonts/dina" \
  "x11-fonts/droid-fonts-ttf" \
  "x11-fonts/freefont-ttf" \
  "x11-fonts/gnu-unifont" \
  "x11-fonts/terminus-font" \
  "x11-fonts/urwfonts" \
  "x11-fonts/webfonts" \
  "x11-fonts/xorg-fonts"
