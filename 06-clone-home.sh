#!/bin/bash

echo -e "setting up home directory...\n"
pushd $HOME
rm -r Documents Desktop Music Pictures Public Templates Videos

hub clone .files --recursive 
hub clone blog --recursive
hub clone cryptography
mkdir img
hub clone backgrounds img/backgrounds
hub clone profile img/profile
hub clone keep
hub clone note
# hub clone uncloak
hub clone cron 
hub clone .private 
popd
