#!/bin/bash
# Commonly used GUIs

sudo apt install -y gnome-tweaks # tweak destkop settings gui
sudo apt install -y vlc # simple playback
sudo apt install -y evince # secondary pdf viewer, after Zotero

# telegram fuckery
# sudo apt install -y telegram-desktop # apt falls out of date a lot
flatpak install -y flathub org.telegram.desktop # apt isn't up to date

# I'm learning: use flatpak > snap in general. Tends to be well maintained, low overhead
flatpak install -y flathub codes.merritt.FeelingFinder # emoji picker
flatpak install -y flathub org.chromium.Chromium
flatpak install -y flathub com.spotify.Client
flatpak install -y flathub md.obsidian.Obsidian
flatpak install -y flathub us.zoom.Zoom  
flatpak install -y flathub org.zotero.Zotero 
flatpak install -y flathub com.github.eneshecan.WhatsAppForLinux
flatpak install -y flathub com.obsproject.Studio
flatpak install -y flathub org.signal.Signal
flatpak install -y flathub com.discordapp.Discord
# https://github.com/micahflee/torbrowser-launcher
flatpak install -y flathub com.github.micahflee.torbrowser-launcher 
flatpak install -y flathub org.gimp.GIMP

# installing code is a mess, every other installation is worse
echo -e "\n\n install vsCode: https://code.visualstudio.com/Download"
echo -e "\n\n install edge: https://www.microsoft.com/en-us/edge/download"
echo -e "\n\n install 1Password: https://1password.com/downloads/linux/"
read -p "press enter to continue"

wget https://github.com/federico-terzi/espanso/releases/download/v2.1.8/espanso-debian-x11-amd64.deb
sudo apt install ./espanso-debian-x11-amd64.deb -y
espanso service register
espanso start
rm espanso-*

# Dead
# flatpak install -y flathub org.mozilla.Thunderbird
# flatpak install -y flathub ch.protonmail.protonmail-bridge 

