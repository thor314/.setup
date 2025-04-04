#!/bin/bash
# Commonly used GUIs

# sudo apt install -y gnome-tweaks # tweak destkop settings gui # already installed do not remove
sudo apt install -y vlc # simple playback
sudo apt install -y evince # secondary pdf viewer, after Zotero

# I'm learning: use flatpak > snap in general. Tends to be well maintained, low overhead
# sudo apt install -y chromium-browser
flatpak install -y flathub org.chromium.Chromium
flatpak install -y flathub md.obsidian.Obsidian
flatpak install -y flathub us.zoom.Zoom  
flatpak install -y flathub org.zotero.Zotero
flatpak install -y flathub com.github.eneshecan.WhatsAppForLinux

flatpak install -y flathub com.discordapp.Discord
# https://github.com/micahflee/torbrowser-launcher
flatpak install -y flathub com.github.micahflee.torbrowser-launcher 
flatpak install -y flathub org.telegram.dekstop
flatpak install -y flathub com.slack.Slack
flatpak install -y flathub codes.merritt.FeelingFinder # emoji picker
# flatpak install -y flathub com.obsproject.Studio
# flatpak install -y flathub org.gimp.GIMP

# https://www.spotify.com/us/download/linux/
# unclear whether flatpak spotify or deb has more more gui issues 
flatpak install -y flathub com.spotify.Client

# signal flatpak has had 3 separate runtime issues in the last year (2025-04-02), use deb install
# flatpak install -y flathub org.signal.Signal
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
sudo mv signal-desktop-keyring.gpg /usr/share/keyrings/
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop

echo "go to telegram settings: advanced: turn off tray icon (and OpenGL if rendering issues), and all notifications"

# installing code is a mess, every other installation is worse
echo -e "\n\n install vsCode: https://code.visualstudio.com/Download"
echo -e "\n\n install android messages: https://github.com/OrangeDrangon/android-messages-desktop/releases/tag/v5.4.2" 
read -p "press enter to continue"


###########
# ARCHIVE #
###########
# old spotify installation
# curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
# echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
# Then you can install the Spotify client:
# sudo apt-get update && sudo apt-get install spotify-client

# firefox --new-tab https://protonvpn.com/support/official-linux-vpn-debian/
# read -p "download the latest protonvpn cli, following the instructions above"

# # zotero install; tried this when flatpak zotero wouldn't obey tdrop
# # https://www.zotero.org/support/installation
# # https://github.com/retorquere/zotero-deb?tab=readme-ov-file
# wget -qO- https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
# sudo apt update
# sudo apt install zotero

# echo -e "\n\n install edge: https://www.microsoft.com/en-us/edge/download"

## Telegram installation notes
# Telegram is annoying. There are 4 installation options.
# - apt: does not seem regularly updated
# - snap: I forget what was up with the snap, besides that it was a snap.
# - flatpak: On desktop, the flatpak has GPU-accel rendering issues. I could probably fix this with the GUI setting.
# - the following download script: WE'LL SEE! 2023-12-20
#wget -O telegram.tar.xz https://telegram.org/dl/desktop/linux
# tar -xf telegram.tar.xz 
# mv Telegram/Telegram ~/.local/bin/telegram
# mv Telegram/Updater ~/.local/bin/telegram-updater
# rm -r Telegram

# Dead, or rather, I don't use these services anymore
# flatpak install -y flathub org.mozilla.Thunderbird
# flatpak install -y flathub ch.protonmail.protonmail-bridge 
# flatpak install -y flathub com.valvesoftware.Steam # steam games seem to only sometimes work on linux
