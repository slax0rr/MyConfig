#!/bin/sh
#
# Lock i3 and suspend or hibernate, depending on input, default suspend
#
MODE=$1
if [ -z $MODE ] || [ "$MODE" -ne "suspend" ] || [ "$MODE" -ne "hibernate" ]; then
    echo "Invalid mode set, defaulting to 'suspend'"
    MODE="suspend"
fi

# Switch to default mode
echo "Switching mode to default"
i3-msg mode default

# Lock the system
echo "Locking the desktop"
i3lock -c 000000

# Put computer to sleep or start hibernation
echo "Waiting for 2 seconds..."
sleep 2
echo "Starting $MODE"
systemctl $MODE
