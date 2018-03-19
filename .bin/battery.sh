#!/bin/sh

export DISPLAY=:0

NS=/usr/bin/notify-send

WARNLVL=30
DANGERLVL=10
CRITLVL=5

FULLENERGY=`cat /sys/class/power_supply/BAT0/energy_full`
CURRENTENERGY=`cat /sys/class/power_supply/BAT0/energy_now`
let CURRENTPERCENT=100*$CURRENTENERGY/$FULLENERGY

if [[ $CURRENTPERCENT -le $CRITLVL ]]; then
    $NS --urgency=critical --icon batery-empty "Battery level critical!" "Battery level is bellow $CRITLVL%, hibernating system in 5 seconds"
    sleep 5
    sudo /usr/sbin/pm-hibernate
    exit 0
elif [[ $CURRENTPERCENT -le $DANGERLVL ]]; then
    $NS --urgency=critical --icon battery-critical "Battery level danger!" "Battery level is bellow $DANGERLVL%, plug in now!"
    exit 0
elif [[ $CURRENTPERCENT -le $WARNLVL ]]; then
    $NS --icon battery "Battery level warning!" "Battery level is bellow $WARNLVL%"
    exit 0
fi
