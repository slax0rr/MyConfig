#!/bin/bash
sleep 0.1
img=$(date '+/tmp/%N.png')
scrot -s -z $img >/dev/null 2>&1 || exit
res=$(curl -n -F "f:1=@$img" -F "ext:1=.png" http://ix.io) && (printf "$res.png" | xclip -f -selection c; printf "\a")
notify-send `echo "$res.png"`
