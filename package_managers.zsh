#!/bin/zsh

echo "let's take this machine FOR A RIDE"
SH="$HOME/.files/setup/sh"
source $SH/setup_checkin.zsh
source $SH/setup_aliases.zsh 
mkdir clones debs # gitignore these
sudo apt update 

# ssh and gpg
$SH/configure_ssh_gpg.zsh
cd $HOME/.files
rm -rf private # didn't get downloaded since we weren't authenticated yet
git clone git@github.com:thor314/private.git 
git submodule add https://github.com/thor314/private private

echo "updating packages" 
$SH/install_rust.zsh 
$SH/install_python.zsh
$SH/install_nodejs.zsh
$SH/install_go.zsh 
$SH/install_vim.zsh 
$SH/install_snap_flatpack.zsh 

# both sudo and user
pipi dotbot 
sudo pipi dotbot 
echo setting up dotfiles...
cd $HOME/.files && dotbot -c install.conf.yaml
rm $HOME/.zsh{_history,env,rc*} # detritus
rm $HOME/.zcompdump*


read "name?what should this machine be called? I will log you out next next. "
sudo hostnamectl set-hostname $name

gnome-session-save --logout
