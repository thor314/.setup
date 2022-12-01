#!/bin/bash


# an ok vpn, but causes problems with updating because no signature?
pushd debs
wget https://protonvpn.com/download/protonvpn-stable-release_1.0.1-1_all.deb
agi gnome-shell-extension-appindicator gir1.2-appindicator3-0.1 #deps
sudo dpkg -i protonvpn-stable-release_1.0.1-1_all.deb
agi protonvpn-cli && popd

# bu dumps
# agi -y fish # not up-to-date
# go here: https://launchpad.net/~fish-shell/+archive/ubuntu/release-3/+packages
# version will likely change. copied fish to .share/bin.
agi fzf # fuzzy finder, also see fd, sd
wget https://launchpad.net/\~fish-shell/+archive/ubuntu/release-3/+files/fish_3.5.1-1\~xenial_amd64.deb
sudo dpkg -i fish_*.deb
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v5 # prompt
fisher install PatrickF1/fzf.fish # fzf tui
fisher install jethrokuan/z # nice frecency cd
fisher install jorgebucaran/nvm.fish # nvm
nvm install latest
fisher install meaningful-ooo/sponge # remove typos from history
# set -U sponge_delay 5 # more than default:  2
fisher install nickeb96/puffer-fish # use ... to go up 2 dirs
fisher install Gazorby/fish-abbreviation-tips # alias reminders
fisher install jhillyerd/plugin-git # git aliases
fisher install shoriminimoe/fish-extract # extraction convenience

# Install misc less-used but maybe useful language servers 
# https://github.com/helix-editor/helix/wiki/How-to-install-the-default-language-servers
npm i -g solc # https://docs.soliditylang.org/en/latest/installing-solidity.html
npm i -g yaml-language-server # https://www.npmjs.com/package/yaml-language-server


