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

sudo apt install webp # webp cli tools
### Proton VPN
firefox --new-tab https://protonvpn.com/support/official-linux-vpn-debian/
echo "download the latest protonvpn cli, following the instructions above"
sleep 3

hub clone --recursive gm $HOME/gm
hub clone --recursive rust-playground
hub clone --recursive python-playground
hub clone --recursive web-playground

# install protonmail gui
pushd debs && wget https://proton.me/download/mail/linux/ProtonMail-desktop-beta.deb && sudo dpkg -i ProtonMail*.deb && popd 

npm i -g --save-exact prettier

wget https://github.com/leona/helix-gpt/releases/download/0.34/helix-gpt-0.34-x86_64-linux.tar.gz \
  -O /tmp/helix-gpt.tar.gz \
  && tar -zxvf /tmp/helix-gpt.tar.gz \
  && mv helix-gpt-0.34-x86_64-linux ~/.local/bin/helix-gpt \
  && chmod +x ~/.local/bin/helix-gpt

  
# -- deprecate
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

sudo apt-get -y install surfraw surfraw-extra # common internet search tools cli

### Web cam manipulation
# note about webcamoid - can't install, remove eventually
# more hassle than worth, akvcam badly documented elsewhere and webcamoid poorly maintained
# # virtual camera for linux, required for linux-fake-background
# firefox --new-tab https://github.com/webcamoid/akvcam/releases
# echo "download latest cli. to install: chmod +x *cli*.run && ./*cli*.run" 
# ----------------

