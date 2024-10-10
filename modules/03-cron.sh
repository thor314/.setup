#!/bin/bash

echo "calling crontab -e, copy and manually paste the following into it"
cat $HOME/.cron/crontab

echo -e "\n\ndon't forget to include a newline at the end of the crontab"
read -p "press enter to continue after you have copied the crontab"
crontab -e

echo -e "\n\nput the following in my sudo crontab:"
echo -e "0 12 * * * apt update && sudo apt upgrade -y"
read -p "press enter to continue after you have copied the crontab"
sudo crontab -e

