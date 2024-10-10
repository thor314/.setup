#!/bin/bash
# apt install stuff

sudo apt install -y fonts-firacode # ligature enabled programming font
sudo apt install -y fonts-karla # https://fonts.google.com/specimen/Karla
# already installed in my fonts backup:
# https://fonts.google.com/specimen/Karla
# https://brailleinstitute.org/freefont
# https://fonts.google.com/specimen/Lora#standard-styles

sudo apt install -y hugo # static site generator blog management
sudo apt install -y gist # github gists
sudo apt install -y pandoc # export text files to other text files 
sudo apt install -y fzf # fuzzy finder, also see fd, sd

# airplay mirroring for ipad to linux; note uxplay sometimes requires `uxplay -avdec` to correctly decode ipad data
sudo apt -y install gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-tools
sudo apt install -y uxplay

# less frequently used or experimental 
sudo apt install -y graphviz # graphing tools, including dot
sudo apt install -y git-filter-repo # useful git tool for selectively filtering git history 
sudo apt install -y shellcheck # https://www.shellcheck.net/ a shell script linter
sudo apt install -y feh # set background image

# archive
# latex - i don't write much anymore, deprecated
# sudo apt install -y texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra


# option to install more bat tools
# https://github.com/eth-p/bat-extras/blob/master/README.md#installation
sudo apt install bat -y
ln -s /usr/bin/batcat ~/.local/bin/bat

