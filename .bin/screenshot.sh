#!/bin/bash
sleep 0.1
img=$(date '+/tmp/%N.png')
if [[ "$2" -eq "full" ]]; then
    scrot -z $img >/dev/null 2>&1 || exit
else
    scrot -s -z $img >/dev/null 2>&1 || exit
fi
res=$(curl -F c=@$img https://ptpb.pw | awk -F'url:' '{print $2}') && (printf $res | xclip -f -selection c; printf "\a")
notify-send `echo $res`
