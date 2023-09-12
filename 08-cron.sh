#!/bin/bash

# set up cronscripts in /var/spool
echo -e "\n\nMake your cron key:"
ssh-keygen -t ed25519 -C thorck@pm.me -f $HOME/.ssh/id_ed25519_cron
ssh-add -k /home/thor/.ssh/id_ed25519_cron
gh ssh-key add $HOME/.ssh/id_ed25519_cron.pub

echo "calling crontab -e, copy and manually paste the following into it"
cat $HOME/.cron/crontab

echo -e "\n\ndon't forget to include a newline at the end of the crontab"
read -p "press enter to continue"
crontab -e

echo -e "\n\nput the following in my sudo crontab:"
echo -e "0 12 * * * apt update && sudo apt upgrade -y"
read -p "press enter to continue"

