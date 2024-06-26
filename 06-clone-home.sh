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

gh repo clone .keep
gh repo clone .cron 

gh repo clone projects

mkdir r 
mkdir fun

popd

# mkdir img && cd img
# gh repo clone backgrounds 
# gh repo clone profile 
# gh repo clone official-images
# cd 

# gh repo clone official
# gh repo clone invoice
