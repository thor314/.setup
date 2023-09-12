#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y 
sudo apt install -y gnome-tweaks # tweak destkop settings gui
echo "Open Gnome Tweaks to map Capslock to Ctrl\n\n"

sudo apt remove ghostscript -y
