#!/bin/sh
#
# Lock i3 and suspend or hibernate, depending on input, default suspend
#
MODE=$1
if [ -z $MODE ] || [ "$MODE" -ne "suspend" ] || [ "$MODE" -ne "hibernate" ]; then
    echo "Invalid mode set, defaulting to 'suspend'"
    MODE="suspend"
fi
echo $MODE
