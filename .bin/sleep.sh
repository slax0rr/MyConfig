#!/bin/bash

if [ $1 != "suspend" ] && [ $1 != "hibernate" ]; then
    i3-nagbar -t error -m "unknown sleep mode '${1}'"
    exit 0
fi

# xss-lock locks on the logind sleep signal itself, no need to lock here
systemctl $1
