#!/bin/bash
# history started 2024-10
read -rp "are you sure you want to run an unsorted script of random nonsense? Ctrl-C to quit, enter to proceed"

# todo: move to home.sh and fine-tune
hub clone --recursive rust-playground
hub clone --recursive python-playground
hub clone --recursive web-playground

# protonmail gui deprecated until they fix their notification bug
pushd debs && wget https://proton.me/download/mail/linux/ProtonMail-desktop-beta.deb && sudo dpkg -i ProtonMail*.deb && popd || exit

# ossify to 00-init.sh 
## Cosmic DE installation 
# enable wayland and adjust DE run settings
sudo sed -i 's/^#\?WaylandEnable=.*$/WaylandEnable=true/' /etc/gdm3/custom.conf
sed -i '/LABEL="gdm_prefer_xorg"/,/LABEL="gdm_end"/ s/^RUN+=/# &/' /usr/lib/udev/rules.d/61-gdm.rules
sudo apt install -y cosmic-session
read -rp "the following will logout. Reboot, and login back in with Cosmic DE. Press enter."
sudo systemctl restart gdm

## pluto circom tooling
git clone https://github.com/iden3/circom.git
cd circom && cargo build --release
cargo install --path circom && cd .. && rm -rf circom
npm install -g snarkjs
sudo apt -y install protobuf-compiler 

# llm
pip install llm
llm keys set openai # paste openai key
llm install llm-cmd

# settings panel to fix sound issues
sudo apt -y install pavucontrol

npm install -g @hackmd/hackmd-cli && hackmd-cli login

# modern colorized strace utility
# https://github.com/sectordistrict/intentrace
cargo binstall -y intentrace

# default pandoc version is years behind (2.9 vs 3.6 as of 2024-12-12)
# https://github.com/jgm/pandoc/releases
wget https://github.com/jgm/pandoc/releases/download/3.6/pandoc-3.6-1-amd64.deb
sudo dpkg -i pandoc-3.6-1-amd64.deb
rm pandoc* 
