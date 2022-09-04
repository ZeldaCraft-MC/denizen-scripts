#!/bin/bash

cd /home/minecraft/git/denizen-scripts

pre_pull=`git rev-parse HEAD`
git pull
post_pull=`git rev-parse HEAD`

if [[ "$pre_pull" != "$post_pull" ]]; then
    echo "Detected changes, updating scripts."
    rsync -a --delete-after shared_scripts/ /home/minecraft/shared_scripts/github-scripts
    for d in `ls servers`; do
        rsync -a --delete-after "servers/$d/" "/home/minecraft/servers/$d/plugins/Denizen/scripts/github-scripts"
    done
fi
