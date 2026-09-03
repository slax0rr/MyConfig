xrdb ~/.Xresources

# i3bar's `tray_output primary` needs a primary output; some single-head
# setups don't have one, which silently kills the systray.
xrandr --query | grep -q " primary" || \
    xrandr --output "$(xrandr --query | awk '/ connected/{print $1; exit}')" --primary

feh --bg-scale ~/Pictures/bg.jpg

~/.local/bin/autolock.sh
