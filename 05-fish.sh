#!/bin/bash

echo -e "\n\nInstall the Fish Shell..."
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish

cargo install lsd # gonna want this 
