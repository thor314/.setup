#!/bin/bash

# install better vim
sudo apt install -y vim-gui-common # fully featured vim
sudo apt install -y vim-runtime # fully featured vim

# install helix while we're at it
sudo add-apt-repository -y ppa:maveonair/helix-editor  
sudo apt update -y
sudo apt install -y helix
