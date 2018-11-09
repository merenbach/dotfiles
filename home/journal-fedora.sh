gnome-tweaks
rclone
vim-enhanced
chromium
sudo dnf install chromium mozilla-ublock-origin
sudo dnf install mozilla-https-everywhere mozilla-privacy-badger
sudo dnf install wine.i686

sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install gstreamer-plugins-bad gstreamer-plugins-good gstreamer-plugins-ugly
gstreamer1-libav gstreamer1-plugins-bad-free gstreamer1-plugins-bad-nonfree gstreamer1-plugins-good gstreamer1-plugins-ugly
sudo dnf install playonlinux
sudo dnf install winetricks
sudo dnf install keepassx
sudo dnf install gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-free-fluidsynth


# for Fallout2, we need: winetricks directx9
# and change WINDOWED=1
# and SCALE_2X=1
# and still there are graphical glitches
# when run with env WINEPREFIX=~/games/wine/fallout2 WINEDLLOVERRIDES="ddraw.dll=n" wine FALLOUT2.EXE
# after installing using fallout.sh script in this repo
