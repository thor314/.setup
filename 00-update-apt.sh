#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y 
sudo apt install -y gnome-tweaks # tweak destkop settings gui

sudo apt remove ghostscript -y
