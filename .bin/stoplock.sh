#!/bin/bash

DEBUG=0
LOGFILE=/tmp/xautolock_debug.log
STATEFILE="/tmp/xautolock_state.txt"
MEDIA_PLAYER_TITLES=("YouTube" "Netflix" "Twitch" "Vimeo")
NON_PLAYER_TITLES=("Meet" "Meeting" "Zoom" "Teams")

log() {
  if [ "$DEBUG" -eq 1 ]; then
    echo "$(date) - $1" >> "$LOGFILE"
  fi
}

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
if [ "$1" == "--debug" ]; then
  DEBUG=1
  echo "Debugging enabled"
fi

read_state() {
  if [ -f "$STATEFILE" ]; then
    cat "$STATEFILE"
  else
    echo "enabled"
  fi
}

save_state() {
  echo "$1" > "$STATEFILE"
}

while true; do
  current_window=$(i3-msg -t get_tree | jq -r '.. | objects | select(.focused==true) | .name')
  current_state=$(read_state)

  if is_matching_window "$current_window" "${MEDIA_PLAYER_TITLES[@]}"; then
    log "Player whitelisted window detected."
    if is_media_playing; then
      log "Media playing detected."
      if [ "$current_state" != "disabled" ]; then
        log "Disabling xautolock."
        xautolock -disable
        save_state "disabled"
      fi
    else
      log "No media playing."
      if [ "$current_state" != "enabled" ]; then
        log "Enabling xautolock."
        xautolock -enable
        save_state "enabled"
      fi
    fi
  elif is_matching_window "$current_window" "${NON_PLAYER_TITLES[@]}"; then
    log "Non-player whitelisted window detected."
    if [ "$current_state" != "disabled" ]; then
      log "Disabling xautolock."
      xautolock -disable
      save_state "disabled"
    fi
  else
    if [ "$current_state" != "enabled" ]; then
      log "Enabling xautolock."
      xautolock -enable
      save_state "enabled"
    fi
  fi

  sleep 10
done
