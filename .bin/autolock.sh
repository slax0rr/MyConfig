#!/bin/bash

if ! [ -x "$(command -v xautolock)" ]; then
    notify-send -u critical -t 10000 -- 'xautolock not installed'
fi

# kill all previous
killall -9 xautolock > /dev/null

xautolock \
    -time 10 \
    -locker "$HOME/.local/bin/i3lock.sh" \
    -notify 30 \
    -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'"
