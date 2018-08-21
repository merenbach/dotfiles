/dev/ada0p1     /usr/home       ufs     rw      1       1
## DEFERRED: service ntpd onefetch
freebsd-update fetch install
portsnap fetch extract
/usr/ports/x11/nvidia-driver
/usr/ports/x11/xorg
sysrc kld_list+="nvidia-modeset"
/usr/ports/shells/bash
/usr/ports/devel/git
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
#/usr/ports/x11-wm/bspwm
/usr/ports/ports-mgmt/portmaster
portmaster -G x11-wm/fvwm2
portmaster -G x11/rofi
portmaster -G x11/compton
