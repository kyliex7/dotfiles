#!/usr/bin/env bash

killall -9 waybar
pgrep niri >/dev/null || niri &
sleep 0.2   # small delay to allow IPC socket creation
waybar &
