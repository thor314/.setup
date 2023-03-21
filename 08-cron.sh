#!/bin/bash

# set up cronscripts in /var/spool
echo "calling crontab -e, copy and manually paste the following into it"
cat $HOME/cron/crontab

echo -e "\n\ndon't forget to include a newline at the end of the crontab"
read -p "Copy and press enter to continue"
crontab -e
