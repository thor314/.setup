#!/bin/sh
# Back up setup 
# set this up in cron to run every 10 minutes

echo "cronlog: $(hostname)-$(date -u +%Y-%m-%d\ %H:%M%Z)" &>> /home/thor/.setup/cron/cronlog

cd /home/thor/.setup
git add --all && git commit -m "$(hostname)-$(date -u +%Y-%m-%d\ %H:%M%Z)" 
git pull 
git push


