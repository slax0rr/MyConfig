#!/bin/bash

SYNC_PATH=~/Documents/cloud
SYNC_USER=slax0r
SYNC_PASS=$(awk '/cloud.lovrec.eu/{getline;getline; print $2}' ~/.netrc)
SYNC_ADDRESS=https://cloud.lovrec.eu

UNSYNCED=~/Documents/.unsynced
EXCLUDE=~/Documents/.exclude

if [[ $RM == "1" ]]; then
    echo "removing"
    rm -rf ${SYNC_PATH}/.sync_*
fi
nextcloudcmd --user ${SYNC_USER} \
    --password $SYNC_PASS \
    --unsyncedfolders ${UNSYNCED} \
    --exclude ${EXCLUDE} \
    --non-interactive \
    ${SYNC_PATH} \
    ${SYNC_ADDRESS}
