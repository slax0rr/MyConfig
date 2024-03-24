#!/bin/bash

if [ $1 != "suspend" ] && [ $1 != "hibernate" ]; then
    i3-nagbar -t error -m "unknown sleep mode '${1}'"
    exit 0
fi

~/.local/bin/i3lock.sh -c 000000

systemctl $1
