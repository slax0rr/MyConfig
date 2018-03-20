#!/bin/sh

export DISPLAY=:0

NS=/usr/bin/notify-send

WARNLVL=30
DANGERLVL=10
CRITLVL=5

STATUS=`cat /sys/class/power_supply/BAT0/status`
if [[ $STATUS != "Discharging" ]]; then
    exit 0
fi
FULLENERGY=`cat /sys/class/power_supply/BAT0/energy_full`
CURRENTENERGY=`cat /sys/class/power_supply/BAT0/energy_now`
let CURRENTPERCENT=100*$CURRENTENERGY/$FULLENERGY

if [[ $CURRENTPERCENT -le $CRITLVL ]]; then
    $NS --urgency=critical --icon battery-empty "Battery level critical!" \
        "Battery level is bellow $CRITLVL%, hibernating system in 1 minute connect AC now to prevent hibernation"
    sleep 60
    STATUS=`cat /sys/class/power_supply/BAT0/status`
    if [[ $STATUS == "Charging" ]]; then
        $NS --urgency=critical --icon battery-low-charging "AC Connected" "Detected AC connection, aborting hibernation"
        exit 0
    fi
    sudo /usr/sbin/pm-hibernate
    exit 0
elif [[ $CURRENTPERCENT -le $DANGERLVL ]]; then
    $NS --urgency=critical --icon battery-low "Battery level danger!" \
        "Battery level is bellow $DANGERLVL%, plug in now! ($CURRENTPERCENT%)"
    exit 0
elif [[ $CURRENTPERCENT -le $WARNLVL ]]; then
    $NS --icon battery "Battery level warning!" "Battery level is bellow $WARNLVL% ($CURRENTPERCENT%)"
    exit 0
fi
