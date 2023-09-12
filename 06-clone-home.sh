#!/bin/bash

echo -e "setting up home directory...\n"
pushd $HOME
rm -r Documents Desktop Music Pictures Public Templates Videos

gh repo clone .private
gh repo clone .files

pip install dotbot
PATH="$PATH:$HOME/.local/bin"
cd $HOME/.files && dotbot -c install.conf.yaml && cd
cd $HOME/.private && dotbot -c install.conf.yaml && cd

gh repo clone blog 
mkdir img && cd img
gh repo clone backgrounds 
gh repo clone profile 
cd 
gh repo clone keep
gh repo clone cron 
popd
