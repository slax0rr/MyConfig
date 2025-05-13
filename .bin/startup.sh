xrdb ~/.Xresources

feh --bg-scale ~/Pictures/bg.jpg

~/.local/bin/stoplock.sh &

xautolock -time 5 -locker ~/.local/bin/i3lock.sh -detectsleep &
