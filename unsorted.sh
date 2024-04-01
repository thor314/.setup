#!/usr/bin/env fish 
echo "hey idiot, don't run this script, it's unstable AF. Run lines one-by-one"
echo "    _ _   "
echo "   /    \ "
echo "  /      |"
echo " / bonk /"
echo "/      / "
echo "|     /  "
echo "|    /   "
echo "|   /    "
echo " \ /     "
echo " ||      "
echo " ||      "
exit 1

# recent commands (as of 2023-03-21)
flatpak install -y flathub com.slack.Slack
flatpak install -y flathub com.valvesoftware.Steam # steam games seem to only sometimes work on linux

# Penumbra cli
# https://guide.penumbra.zone/main/pcli/install.html#linux
sudo apt install build-essential pkg-config libssl-dev clang git-lfs -y
git clone https://github.com/penumbra-zone/penumbra clones
#cd clones/penumbra && git fetch && git checkout v0.63.1
#cargo build --release --bin pcli
#cp target/release/pcli ~/.cargo/bin
## New:
# cargo run --quiet --release --bin pcli init soft-kms generate
## Import:
# cargo run --quiet --release --bin pcli init soft-kms import-phrase
# generate the address for a numbered account between 0 and 4 billion
# cargo run --quiet --release --bin pcli view address 0

sudo apt install webp # webp cli tools
sudo apt-get -y install surfraw surfraw-extra # common internet search tools cli

### Web cam manipulation
# note about webcamoid - can't install, remove eventually
# more hassle than worth, akvcam badly documented elsewhere and webcamoid poorly maintained
# # virtual camera for linux, required for linux-fake-background
# firefox --new-tab https://github.com/webcamoid/akvcam/releases
# echo "download latest cli. to install: chmod +x *cli*.run && ./*cli*.run" 

### Proton VPN
firefox --new-tab https://protonvpn.com/support/official-linux-vpn-debian/
echo "download the latest protonvpn cli, following the instructions above"
sleep 3

# ssh key manager
sudo apt -y install keychain

hub clone --recursive gm $HOME/gm
hub clone --recursive rust-playground
hub clone --recursive python-playground
hub clone --recursive web-playground

# mkdeb, a simplicity focused pcakaging tool for debian archives
# https://www.makedeb.org/
bash -ci "$(wget -qO - 'https://shlink.makedeb.org/install')"

# just, a command runner
# https://github.com/casey/just#shell-completion-scripts
git clone https://mpr.makedeb.org/just
pushd just
makedeb -si
sudo dpkg -i just_*_amd64.deb
popd
