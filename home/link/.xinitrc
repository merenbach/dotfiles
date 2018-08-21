#! /bin/sh
#userresources=$HOME/.Xdefaults
#if [ -f "$userresources" ]; then
#    xrdb -merge "$userresources"
#fi

# Disable bell
xset -b

# Enable zapping (C-A-<Bksp> kills X)
setxkbmap -option terminate:ctrl_alt_bksp

# Swap caps lock and escape
setxkbmap -option caps:swapescape

# Swap alt and ctrl
#setxkbmap ....

# Reverse scroll direction
# xmodmap -e 'pointer = 1 2 3 5 4'

xautolock &

# Start compositor
compton -b

# Add SSH key
#eval `ssh-agent`
#ssh-add < /dev/null

# Set mouse acceleration (2.0) and threshold (2px)
# (Before tweaking, make sure mouse doesn't have its own hardware switch!)
#xset mouse 20/16 4

# turn off screen after ten minutes
xset dpms 600 600 600

# Set wallpaper
#feh --bg-fill "$HOME/wallpaper"

# Start the WM now
exec /usr/local/bin/fvwm

# Start i3 and log to ~/.i3/logfile
#echo "Starting at `date`" >> ~/.i3/logfile
#/usr/local/bin/sxhkd &
#exec /usr/local/bin/bspwm -c ~/.bspwmrc
#exec /usr/local/bin/fvwm
#exec /usr/local/bin/i3 -V -d all >> ~/.i3logfile
