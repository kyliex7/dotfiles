#!/usr/bin/env bash

if xrandr | grep "HDMI-1 connected"; then
    xrandr --output eDP-1 --off --output HDMI-1 --primary --mode 1920x1080 &>/dev/null
    notify-send Using HDMI-1
else
    xrandr --output eDP-1 --auto --primary &>/dev/null
    notify-send Using eDP-1
fi
