#!/bin/bash

cargo install --locked bat # better than cat and less
pushd $HOME/.setup/clones
hub clone https://github.com/eth-p/bat-extras # bat(diff|grep|man|pipe|watch)
cd bat-extras 
sudo apt install gawk # dependency
./build.sh
# maybe necessary if installed via sudo:
# git config --global --add safe.directory /home/thor/.files/setup/clone/bat-extras
popd

