#!/bin/bash

MEDIA_PLAYER_TITLES=("YouTube" "Netflix" "Twitch" "Vimeo")
NON_PLAYER_TITLES=("Meet -" "Meeting" "Zoom")

is_matching_window() {
  local current_window="$1"
  shift
  local keywords=("$@")
  for keyword in "${keywords[@]}"; do
    if echo "$current_window" | grep -iq "$keyword"; then
      return 0
    fi
  done
  return 1
}

is_media_playing() {
  playerctl --player=brave status 2>/dev/null | grep -iq "playing"
}

while true; do
  current_window=$(i3-msg -t get_tree | jq -r '.. | objects | select(.focused==true) | .name')

  if is_matching_window "$current_window" "${MEDIA_PLAYER_TITLES[@]}"; then
    if is_media_playing; then
      xautolock -disable
    else
      xautolock -enable
    fi
  elif is_matching_window "$current_window" "${NON_PLAYER_TITLES[@]}"; then
    xautolock -disable
  else
    xautolock -enable
  fi

  sleep 10
done
