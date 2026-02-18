#!/bin/bash
# claude-notify.sh
# Called by Claude Code's Notification hook.
# 1. Sends a desktop notification via notify-send
# 2. Rings the bell on the parent alacritty's pts so i3 marks it urgent (red title bar)

PAYLOAD=$(cat)

# Extract message from JSON payload
MESSAGE=$(printf '%s' "$PAYLOAD" | python3 -c "
import json, sys
try:
    d = json.load(sys.stdin)
    print(d.get('message', 'Claude needs your input'))
except Exception:
    print('Claude needs your input')
" 2>/dev/null)
MESSAGE=${MESSAGE:-"Claude needs your input"}

# Desktop notification (critical urgency, 15 s timeout)
notify-send -u critical -t 15000 "Claude Code" "$MESSAGE" 2>/dev/null &

# Walk up the process tree to find the alacritty PID
find_alacritty_pid() {
    local pid=$$
    while [ "$pid" -gt 1 ]; do
        local comm
        comm=$(cat /proc/$pid/comm 2>/dev/null)
        if [ "$comm" = "alacritty" ]; then
            echo "$pid"
            return
        fi
        local ppid
        ppid=$(awk '/^PPid:/{print $2}' /proc/$pid/status 2>/dev/null)
        [ -z "$ppid" ] && break
        pid=$ppid
    done
}

ring_bell() {
    local alacritty_pid
    alacritty_pid=$(find_alacritty_pid)
    [ -z "$alacritty_pid" ] && return

    # The direct child of alacritty is the outer shell whose fd/0 is the pts slave
    local child_pid pts
    child_pid=$(pgrep -P "$alacritty_pid" 2>/dev/null | head -1)
    [ -z "$child_pid" ] && return

    pts=$(readlink /proc/$child_pid/fd/0 2>/dev/null)
    [[ "$pts" == /dev/pts/* ]] || return

    printf '\a' > "$pts"
}

ring_bell &
wait
