#!/bin/bash
# rofi emoji https://github.com/Mange/rofi-emoji
# assume rofi is already installed, but run anyway:
sudo apt install -y rofi

pushd $HOME/.setup/clones
git clone git@github.com:Mange/rofi-emoji.git 
cd rofi-emoji
# if not installed, install
sudo apt install -y rofi-dev autoconf automake libtool-bin libtool
autoreconf -i
mkdir build
cd build/
../configure
make
sudo make install
popd
# then bind
# rofi -show emoji -modi emoji
# to a hotkey
