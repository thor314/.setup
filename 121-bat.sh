#!/bin/bash

sudo apt install -y shfmt # dependency, minify scripts
cargo install --locked bat # better than cat and less
pushd $HOME/.setup/clones
hub clone https://github.com/eth-p/bat-extras # bat(diff|grep|man|pipe|watch)
cd bat-extras 
sudo apt install -y gawk # dependency
./build.sh --install --prefix="/home/thor/.cargo/bin/bat-extras"
# maybe necessary if installed via sudo:
# git config --global --add safe.directory /home/thor/.files/setup/clone/bat-extras
popd

