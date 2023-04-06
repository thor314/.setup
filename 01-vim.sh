#!/bin/bash

# install better vim
sudo apt install vim-gui-common # fully featured vim
sudo apt install vim-runtime # fully featured vim

# install helix while we're at it
sudo add-apt-repository ppa:maveonair/helix-editor
sudo apt update
sudo apt install helix
