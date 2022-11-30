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
fisher install IlanCosman/tide@v5
fisher install PatrickF1/fzf.fish

