#!/bin/bash
# this script installs basic tools like ssh, gpg, fish, alacritty, programming languages

# apt upgrades, if we haven't already
sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y

# settings gui to twiddle while we wait
sudo apt install -y gnome-tweaks 

# annoying package
sudo apt remove ghostscript -y

# install better vim
sudo apt install -y vim-gui-common # fully featured vim
sudo apt install -y vim-runtime # fully featured vim

# install helix while we're at it
sudo add-apt-repository -y ppa:maveonair/helix-editor
sudo apt update -y
sudo apt install -y helix

# common deps
sudo apt install -y clang curl libssl-dev llvm pkg-config shfmt

# package managers
sudo apt install -y snapd
sudo apt install -y flatpak

# languages
sudo apt install -y python3-dev python3-pip python3-setuptools

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup update && rustup toolchain install nightly && rustup default nightly
cargo install cargo-binstall # fast cargo binary installer
cargo binstall -y lsd # don't wait to install my ls command

# this version needs to be updated pretty much every time
wget https://go.dev/dl/go1.23.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go 
sudo tar -C /usr/local -xzf go*
export PATH=$PATH:/usr/local/go/bin && go version 
rm go*

# clipboard conveniences
sudo apt install -y xclip

# set up ssh server
sudo apt install -y openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh
echo -e "\n\nmy ip address is:"
echo -e "$(hostname -I | cut --delimiter=' ' -f1)\n\n"
echo "get shared key from another machine. From my other trusted machine, enter:"
echo "gpg --export-secret-keys thor-shared | ssh thor@IPADDRESS gpg --import"
echo "note that not all my users are named thor"
read -p "waiting for user..."

# keychain checks for running ssh-agent, saves pw entry
# https://man.archlinux.org/man/extra/keychain/keychain.1.en
sudo apt install -y keychain

echo -e "\n\nInstall the Fish Shell..."
sudo apt-add-repository -y ppa:fish-shell/release-3 
sudo apt update
sudo apt install -y fish

echo -e "\n\nInstall alacritty"
# from https://github.com/alacritty/alacritty/blob/master/INSTALL.md#debianubuntu
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 scdoc
git clone git@github.com:alacritty/alacritty.git
cd alacritty
cargo build --release
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/man/man5
scdoc < extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
scdoc < extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
scdoc < extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz > /dev/null
scdoc < extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz > /dev/null
cd ..
rm -rf alacritty

# tell me to do stuff
echo "you may open gnome tweaks to adjust capslock to ctrl."

# NVM/NPM/Node - maybe deprecated 
# mkdir $HOME/.config/nvm
# wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# nvm install node
# npm install pnpm

# maybe deprecated
# This will run in the background, reducing 2FA weight when talking to github
# https://github.com/microsoft/Git-Credential-Manager-Core#linux-install-instructions
# Download the .deb file
# gcm_version=$( curl -s 'https://api.github.com/repos/git-ecosystem/git-credential-manager/releases/latest' |  jq -r ".tag_name" |  cut -c 2- )
# wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v${gcm_version}/gcm-linux_amd64.${gcm_version}.deb
# sudo dpkg -i ./gcm-linux_amd64.${gcm_version}.deb
# git-credential-manager configure

