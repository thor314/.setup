#!/bin/bash
# Commonly used GUIs
sudo apt install -y gnome-tweaks # tweak destkop settings gui
sudo apt install -y vlc # simple playback
sudo apt install -y evince # secondary pdf viewer, after Zotero
echo -e "\n\n install 1Password: https://1password.com/downloads/linux/"
read -p "press enter to continue"

# I'm learning: use flatpak > snap in general. Tends to be well maintained, low overhead
flatpak install -y flathub codes.merritt.FeelingFinder # emoji picker
flatpak install -y flathub org.chromium.Chromium
flatpak install -y flathub com.spotify.Client
flatpak install -y flathub md.obsidian.Obsidian
flatpak install -y flathub us.zoom.Zoom  
flatpak install -y flathub org.zotero.Zotero 
flatpak install -y flathub com.github.eneshecan.WhatsAppForLinux
flatpak install -y flathub com.obsproject.Studio
sudo apt uninstall firefox
flatpak install -y flathub org.mozilla.Thunderbird
flatpak install -y flathub org.mozilla.firefox
flatpak install -y flathub ch.protonmail.protonmail-bridge 
flatpak install -y flathub org.signal.Signal
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub org.telegram.desktop
# https://github.com/micahflee/torbrowser-launcher
flatpak install -y flathub com.github.micahflee.torbrowser-launcher 

# installing code is a mess, every other installation is worse
echo -e "\n\n install vsCode: https://code.visualstudio.com/Download"
pushd $HOME/.setup/clones && wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 && sudo dpkg -i ./code_*_amd64.deb && popd

# generally prefer flatpak over snap, seems better maintained, more native in general.
# text-expander no flatpak
snap install espanso --classic --channel=latest/edge # text expander
snap run espanso service register
snap run espanso start
