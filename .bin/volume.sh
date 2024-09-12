#!/bin/bash

# Define the notification ID (a unique ID for the volume notifications)
NOTIFY_ID=91234

# Get the current sink name (replace with your actual sink name if needed)
SINK=$(pactl info | grep "Default Sink" | awk '{print $3}')

# Adjust the volume
if [ "$1" == "up" ]; then
  pactl set-sink-volume "$SINK" +5%
elif [ "$1" == "down" ]; then
  pactl set-sink-volume "$SINK" -5%
elif [ "$1" == "toggle" ]; then
  pactl set-sink-mute "$SINK" toggle
fi

# Get the current volume level
VOL=$(pactl get-sink-volume "$SINK" | awk '{print $5}' | sed 's/%//')

# Get mute status
MUTE=$(pactl get-sink-mute "$SINK" | awk '{print $2}')

# Create the notification message
if [ "$MUTE" == "yes" ]; then
  MESSAGE="Muted"
else
  MESSAGE="Volume: $VOL%"
fi

# Send or update the notification
notify-send -u normal -t 5000 -i audio-volume-high "$MESSAGE" -r $NOTIFY_ID
