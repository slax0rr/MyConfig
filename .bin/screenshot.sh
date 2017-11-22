#!/bin/bash
sleep 0.1
img=$(date '+/tmp/%N.png')
scrot -s -z $img >/dev/null 2>&1 || exit
res=$(curl -F c=@$img https://ptpb.pw | awk -F'url:' '{print $2}') && (printf $res | xclip -f -selection c; printf "\a")
notify-send `echo $res`
