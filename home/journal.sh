echo /dev/ada0p1     /usr/home       ufs     rw      1       1 >> /etc/fstab

# ideally copy /etc/make.conf into place before compiling

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

cd /usr/ports/ports-mgmt/portmaster
make install clean BATCH=yes

portmaster -G -d --no-confirm security/ca_root_nss
service ntpd onefetch

portmaster -G -d --no-confirm /usr/ports/x11/nvidia-driver
sysrc kld_list+="nvidia-modeset"

portmaster -G -d --no-confirm /usr/ports/x11/xorg

portmaster -G -d --no-confirm devel/dbus
sysrc dbus_enable="YES"

sysrc devd_enable=YES

portmaster -G -d --no-confirm x11-wm/fvwm2
portmaster -G -d --no-confirm x11/rofi
portmaster -G -d --no-confirm x11/compton

portmaster -G -d --no-confirm /usr/ports/shells/bash
portmaster -G -d --no-confirm /usr/ports/devel/git

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
