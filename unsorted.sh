#!/bin/bash


# an ok vpn, but causes problems with updating because no signature?
pushd debs
wget https://protonvpn.com/download/protonvpn-stable-release_1.0.1-1_all.deb
agi gnome-shell-extension-appindicator gir1.2-appindicator3-0.1 #deps
sudo dpkg -i protonvpn-stable-release_1.0.1-1_all.deb
agi protonvpn-cli && popd

# bu dumps
agi -y fish
