#!/usr/bin/env fish
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y nvidia-graphics-drivers-396 nvidia-settings vulkan vulkan-utils

sudo add-apt-repository ppa:oibaf/graphics-drivers
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y libvulkan1 mesa-vulkan-drivers vulkan-utils

sudo apt-get install -y curl build-essential python cmake pkg-config
sudo apt-get install -y libasound2-dev
sudo apt install -y libxcb-shape0-dev libxcb-xfixes0-dev
sudo apt-get install -y vulkan-tools

