#! /usr/bin/env sh

LC_CTYPE="en_US.UTF-8"
export LC_CTYPE

LANG="en_US.UTF-8"
export LANG

# Disable bell
xset -b

# Enable zapping (C-A-<Bksp> kills X)
setxkbmap -option terminate:ctrl_alt_bksp

# Swap Escape and Caps Lock
setxkbmap -option caps:swapescape

# Start some apps

# xidle ignores .Xdefaults when started here
xidle -delay 5 -timeout 300 &
xbindkeys
compton -b

# Set wallpaper
feh --bg-fill ~/IMG_0054.JPG

# Start Xfce4 (--with-ck-launch requires amessagebus service)
exec /usr/local/bin/startxfce4 --with-ck-launch

# Start i3 and log to ~/.i3/logfile
#echo "Starting at $(date)" >> ~/.i3/logfile
#exec /usr/local/bin/i3 -V -d all >> ~/.i3/logfile
