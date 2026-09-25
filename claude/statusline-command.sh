#!/bin/bash
# Status line: model, session spend, context usage, 5h/7d rate-limit usage.
#
# JSON fields used (from the statusLine stdin payload):
#   model.display_name
#   cost.total_cost_usd
#   context_window.used_percentage (null before the first response -> "n/a")
#   rate_limits.five_hour.used_percentage
#   rate_limits.five_hour.resets_at
#   rate_limits.seven_day.used_percentage
#   rate_limits.seven_day.resets_at
#   (rate_limits.* are absent until the first API response -> "n/a")

JQ_BIN=/opt/homebrew/bin/jq
[ -x "$JQ_BIN" ] || JQ_BIN=$(command -v jq)

input=$(cat)
now=$(date +%s)

# Emits (as literal, unprocessed text) the ANSI color escape for a usage
# percentage: green <50, yellow 50-79, red >=80.
color_for_pct() {
    local pct=$1
    if [ "$pct" -ge 80 ]; then
        printf '%s' '\033[31m'
    elif [ "$pct" -ge 50 ]; then
        printf '%s' '\033[33m'
    else
        printf '%s' '\033[32m'
    fi
}

# Formats a remaining-seconds count as a compact duration:
#   >=1 day  -> "1d8h"
#   >=1 hour -> "3h5m"
#   <1 hour  -> "12m"
format_duration() {
    local secs=$1
    [ "$secs" -lt 0 ] && secs=0
    local days=$(( secs / 86400 ))
    local hours=$(( (secs % 86400) / 3600 ))
    local minutes=$(( (secs % 3600) / 60 ))
    if [ "$days" -ge 1 ]; then
        printf '%dd%dh' "$days" "$hours"
    elif [ "$secs" -ge 3600 ]; then
        printf '%dh%dm' "$hours" "$minutes"
    else
        printf '%dm' "$minutes"
    fi
}

segments=()

# 1. Model
model=$(printf '%s' "$input" | "$JQ_BIN" -r '.model.display_name // empty')
[ -n "$model" ] && segments+=("🧠 ${model}")

# 2. Session spend
cost=$(printf '%s' "$input" | "$JQ_BIN" -r '.cost.total_cost_usd // empty')
if [ -n "$cost" ]; then
    cost_fmt=$(printf '%.2f' "$cost")
    segments+=("💵 \$${cost_fmt}")
fi

# 3. Context-window usage
ctx_pct=$(printf '%s' "$input" | "$JQ_BIN" -r '.context_window.used_percentage // empty')
if [ -n "$ctx_pct" ]; then
    pct_int=$(printf '%.0f' "$ctx_pct")
    color=$(color_for_pct "$pct_int")
    segments+=("🗄️ ${color}${pct_int}%\033[0m")
else
    segments+=("🗄️ n/a")
fi

# 4. 5-hour rate limit
five_pct=$(printf '%s' "$input" | "$JQ_BIN" -r '.rate_limits.five_hour.used_percentage // empty')
five_reset=$(printf '%s' "$input" | "$JQ_BIN" -r '.rate_limits.five_hour.resets_at // empty')
if [ -n "$five_pct" ] && [ -n "$five_reset" ]; then
    pct_int=$(printf '%.0f' "$five_pct")
    color=$(color_for_pct "$pct_int")
    dur=$(format_duration $(( five_reset - now )))
    segments+=("⏳ 5h ${color}${pct_int}%\033[0m (${dur})")
else
    segments+=("⏳ 5h n/a")
fi

# 5. 7-day rate limit
seven_pct=$(printf '%s' "$input" | "$JQ_BIN" -r '.rate_limits.seven_day.used_percentage // empty')
seven_reset=$(printf '%s' "$input" | "$JQ_BIN" -r '.rate_limits.seven_day.resets_at // empty')
if [ -n "$seven_pct" ] && [ -n "$seven_reset" ]; then
    pct_int=$(printf '%.0f' "$seven_pct")
    color=$(color_for_pct "$pct_int")
    dur=$(format_duration $(( seven_reset - now )))
    segments+=("📅 7d ${color}${pct_int}%\033[0m (${dur})")
else
    segments+=("📅 7d n/a")
fi

out=""
for seg in "${segments[@]}"; do
    if [ -z "$out" ]; then
        out="$seg"
    else
        out="${out}  ${seg}"
    fi
done

printf '%b' "$out"
