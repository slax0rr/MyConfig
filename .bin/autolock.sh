#!/bin/bash

if ! [ -x "$(command -v xss-lock)" ]; then
    notify-send -u critical -t 10000 -- 'xss-lock not installed'
    exit 1
fi

# kill all previous
killall -9 xss-lock xssproxy > /dev/null 2>&1

# idle timeout (seconds) after which the X server fires the screen saver
xset s 300 300
xset dpms 0 0 330

# translate org.freedesktop.ScreenSaver inhibit requests (browsers playing
# video, video calls, mpv, ...) into real X screen saver suspension
xssproxy &

# -l holds the systemd sleep lock until i3lock is actually up
xss-lock -l -- "$HOME/.local/bin/i3lock.sh" &
