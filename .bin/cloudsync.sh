#!/bin/bash

SYNC_PATH=~/Documents/cloud
SYNC_USER=slax0r
SYNC_ADDRESS=https://cloud.lovrec.eu

UNSYNCED=~/Documents/.unsynced
EXCLUDE=~/Documents/.exclude

if [[ $RM == "1" ]]; then
    echo "removing"
    rm -rf ${SYNC_PATH}/.sync_*
fi
nextcloudcmd --user ${SYNC_USER} \
    --unsyncedfolders ${UNSYNCED} \
    --exclude ${EXCLUDE} \
    -n \
    --non-interactive \
    ${SYNC_PATH} \
    ${SYNC_ADDRESS}
