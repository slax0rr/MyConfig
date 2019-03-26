#!/bin/bash

XI=/usr/bin/xinput
G=/usr/bin/grep
C=/usr/bin/cut
A=/usr/bin/awk

TOUCHPADID=`xinput --list | awk -v search="TouchPad" '$0 ~ search {match($0 , /id=[0-9]+/);if (RSTART) print substr($0, RSTART+3, RLENGTH-3)}'`
TRACKPADID=`xinput --list | awk -v search="TrackPoint" '$0 ~ search {match($0 , /id=[0-9]+/);if (RSTART) print substr($0, RSTART+3, RLENGTH-3)}'`

TOUCHENABLED=`$XI list-props $TOUCHPADID | $G -i "device enabled" | $C -s -d: -f2 | $A {'print $1'}`
TRACKENABLED=`$XI list-props $TRACKPOINTID | $G -i "device enabled" | $C -s -d: -f2 | $A {'print $1'}`

TOUCHCMD="enable"
if [[ $TOUCHENABLED -eq 1 ]]; then
    TOUCHCMD="disable"
fi
TRACKCMD="enable"
if [[ $TRACKENABLED -eq 1 ]]; then
    TRACKCMD="disable"
fi

if [[ "$1" == "enable" ]] || [[ "$1" == "disable" ]]; then
    TOUCHCMD=$1
    TRACKCMD=$1
fi

$XI $TOUCHCMD "${TOUCHPADID}"
$XI $TRACKCMD "${TRACKPOINTID}"
