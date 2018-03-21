#! /bin/sh
userresources=$HOME/.Xresources
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# Swap alt and ctrl
#setxkbmap ....

# Reverse scroll direction
xmodmap -e 'pointer = 1 2 3 5 4'

#pgrep xbindkeys || xbindkeys
#xautolock -time 10 -locker /usr/local/bin/slock &

#compton -b

# Add SSH key
#eval `ssh-agent`
#ssh-add < /dev/null

# Set mouse acceleration (2.0) and threshold (2px)
# (Before tweaking, make sure mouse doesn't have its own hardware switch!)
xset mouse 20/16 4

# turn off screen after ten minutes
xset dpms 600 600 600

# Disable hardware beep
xset -b

# Set wallpaper
#feh --bg-fill "$HOME/wallpaper"

# Start the WM now
exec /usr/local/bin/i3
#exec /usr/local/bin/fvwm
