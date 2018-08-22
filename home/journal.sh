#! /bin/sh

bootstrap() {
    echo /dev/ada0p1     /usr/home       ufs     rw      1       1 >> /etc/fstab
    portsnap fetch extract
    freebsd-update fetch install
    /usr/bin/make -C /usr/ports/ports-mgmt/portmaster install clean BATCH=yes
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

install "shells/bash"
install "shells/bash-completion"

chsh -s /usr/local/bin/bash andrew

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
install "ftp/curl"

# to install
install "x11/arandr"
install "archivers/unzip"
install "archivers/zip"
install "devel/awscli"
install "ftp/wget"
#install "graphics/feh"
install "math/calc"
install "net-mgmt/whatmask"
install "net/rclone"
install "net/rsync"
install "security/nmap"
install "sysutils/cmdwatch"
install "sysutils/pwgen"
install "textproc/dict"
install "textproc/jq"
install "textproc/the_silver_searcher"

install "security/keepassx2"
install "x11/rxvt-unicode"
install "x11/urxvt-perls"
install "graphics/xpdf"
#install "x11/xsel"

install "editors/libreoffice"
install "editors/texmaker"
install "graphics/gimp"
install "print/texlive-full"
install "textproc/hs-pandoc"
install "www/firefox"
install "www/chromium"

install "devel/git"
install "editors/vim"
install "editors/emacs"
install "lang/gcc7"
install "lang/ghc"
install "lang/go"
install "lang/python3"
install "lang/rust"
install "lang/racket-minimal"
install "misc/sloccount"

install "devel/hs-cabal-install"
# install "devel/stack"

install "emulators/dosbox"
install "emulators/i386-wine-devel"
install "emulators/wine-gecko-devel"
install "emulators/wine-mono-devel"
/bin/sh /usr/local/share/wine/patch-nvidia.sh
install "emulators/winetricks"

install "games/alephone"
install "games/alephone-data"
install "games/alephone-scenarios"
install "games/angband"
install "games/scummvm"
install "games/scummvm-tools"
