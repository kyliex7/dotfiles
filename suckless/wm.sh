#!/bin/sh

xrandr --output eDP-1 --off --output HDMI-1 --primary --mode 1280x1024
picom &
feh --bg-scale ~/Pictures/wallpapers/wallhaven-yxrkm7.png
xset r rate 300 30

# Run dwmstatus in the background loop
dwmstatus 2>&1 >/dev/null &

# Run dwm once (no restart loop)
exec dwm 2>~/.dwm.log
