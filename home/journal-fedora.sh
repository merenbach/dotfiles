dnf update

# if reinstalling OS, to mount /home...
# /etc/fstab: => /dev/mapper/luks-7f9579cd-e497-4ac7-be6a-8782c657c30b /home                   xfs    defaults,x-systemd.device-timeout=0 1 2
# /etc/crypttab: => luks-7f9579cd-e497-4ac7-be6a-8782c657c30b UUID=7f9579cd-e497-4ac7-be6a-8782c657c30b none discard

# for Xorg with AMD:
# sudo dnf install xorg-x11-drv-amdgpu
# may also need:
#cat /etc/X11/xorg.conf.d/20-amdgpu.conf
#Section "Device"
#    Identifier "AMD"
#    Driver "amdgpu"
#EndSection

# DISABLE CSMT IN WINECFG IN FEDORA


sudo dnf install microcode_ctl

sudo dnf install awscli
sudo dnf install calc
sudo dnf install curl
sudo dnf install emacs
sudo dnf install git
sudo dnf install golang
sudo dnf install jq
sudo dnf install nmap
sudo dnf install pandoc
sudo dnf install patch
sudo dnf install pwgen
sudo dnf install rclone
sudo dnf install ripgrep
sudo dnf install rsync
sudo dnf install rust cargo
sudo dnf install sloccount
sudo dnf install texlive
sudo dnf install vim-commentary
sudo dnf install vim-enhanced vim-fugitive vim-go
sudo dnf install wget
sudo dnf install whatmask
sudo dnf install zip unzip

sudo dnf install chromium
sudo dnf install dosbox
sudo dnf install firefox
sudo dnf install gimp
sudo dnf install gnome-tweaks
sudo dnf install gramps
sudo dnf install keepassx
sudo dnf install mozilla-ublock-origin mozilla-https-everywhere mozilla-privacy-badger
sudo dnf install scummvm
sudo dnf install wine.i686
sudo dnf install winetricks


sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install gstreamer-plugins-bad gstreamer-plugins-good gstreamer-plugins-ugly
gstreamer1-libav gstreamer1-plugins-bad-free gstreamer1-plugins-bad-nonfree gstreamer1-plugins-good gstreamer1-plugins-ugly
sudo dnf install playonlinux
sudo dnf install gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-free-fluidsynth
sudo dnf install ffmpeg-libs
# use this to support H.264 video (e.g., YouTube) in Chromium
sudo dnf install chromium-libs-media-freeworld

# VS Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code


# for Fallout2, we need: winetricks directx9
# and change WINDOWED=1
# and SCALE_2X=1
# and still there are graphical glitches
# when run with env WINEPREFIX=~/games/wine/fallout2 WINEDLLOVERRIDES="ddraw.dll=n" wine FALLOUT2.EXE
# after installing using fallout.sh script in this repo
