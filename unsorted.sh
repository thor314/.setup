#!/bin/bash


# an ok vpn, but causes problems with updating because no signature?
pushd debs
wget https://protonvpn.com/download/protonvpn-stable-release_1.0.1-1_all.deb
agi gnome-shell-extension-appindicator gir1.2-appindicator3-0.1 #deps
sudo dpkg -i protonvpn-stable-release_1.0.1-1_all.deb
agi protonvpn-cli && popd

# bu dumps
# agi -y fish #  NONONO not up-to-date will break 
# go here: https://launchpad.net/~fish-shell/+archive/ubuntu/release-3/+packages
# version will likely change. copied fish to .share/bin.
agi fzf # fuzzy finder, also see fd, sd

# May have to install this first:
# sudo apt install libtinfo5
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

## Install misc less-used but maybe useful language servers 
# https://github.com/helix-editor/helix/wiki/How-to-install-the-default-language-servers
npm i -g yaml-language-server # https://www.npmjs.com/package/yaml-language-server
npm i -g vscode-html-languageservice # https://github.com/microsoft/vscode-html-languageservice
npm i -g typescript-language-server typescript # https://github.com/typescript-language-server/typescript-language-server
npm i -g dockerfile-language-server-nodejs # https://github.com/rcjsuen/dockerfile-language-server-nodejs
npm i -g vscode-langservers-extracted # vscode's HTML/JSON/CSS:  https://github.com/hrsh7th/vscode-langservers-extracted
# https://leanprover-community.github.io/install/debian.html
wget -q https://raw.githubusercontent.com/leanprover-community/mathlib-tools/master/scripts/install_debian.sh && bash install_debian.sh ; rm -f install_debian.sh && source ~/.profile
npm i -g lean-language-server
# Issues:  solc not detected by helix, may be upstream issues *shrug*, not my monkeys
# npm i -g solc # https://docs.soliditylang.org/en/latest/installing-solidity.html
