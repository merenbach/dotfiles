echo /dev/ada0p1     /usr/home       ufs     rw      1       1 >> /etc/fstab

# ideally copy /etc/make.conf into place before compiling

install() {
        /usr/local/sbin/portmaster --no-confirm -B -G -D "$@"
}

sysrc clear_tmp_enable="YES"
sysrc syslogd_flags="-ss"
sysrc sendmail_enable="NONE"
sysrc ntpd_enable="YES"
# onefetch may negate need for this
#sysrc ntpd_sync_on_start="YES"

# this might not be really necessary on a desktop
sysrc powerd_enable="YES"

sysrc dumpdev="NO"

portsnap fetch extract
freebsd-update fetch install

/usr/bin/make -C /usr/ports/ports-mgmt/portmaster install clean BATCH=yes

install security/ca_root_nss
service ntpd onefetch

install x11/xorg

install x11/nvidia-driver
sysrc kld_list+="nvidia-modeset"
kldload nvidia-modeset

install devel/dbus
sysrc dbus_enable="YES"

sysrc devd_enable=YES

install x11-wm/fvwm2
install x11-wm/compton

install shells/bash
chsh -s /usr/local/bin/bash andrew

#nvidia-xconfig --add-argb-glx-visuals --composite --depth=24
cat <<EOF > /usr/local/etc/X11/xorg.conf.d/driver-nvidia.conf
Section "Device"
    Identifier     "Card0"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
#BusID "PCI:1:0:0"
    #Option         "AccelMethod" "none"
    #Option         "TripleBuffer" "True"
    #Option         "MetaModes" "nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
    ##Option         "MetaModes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
EndSection
EOF

install x11/rofi
install devel/git
install ftp/curl
install x11/xlockmore
install x11/xautolock
