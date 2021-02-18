#!/bin/bash

if ! [ -x "$(command -v xautolock)" ]; then
    notify-send -u critical -t 10000 -- 'xautolock not installed'
    exit 1
fi

# kill all previous
killall -9 xautolock > /dev/null

xautolock \
    -time 5 \
    -locker "$HOME/.local/bin/i3lock.sh" \
    -detectsleep &
