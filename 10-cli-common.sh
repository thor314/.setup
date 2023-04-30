#!/bin/bash
# cli tools used frequently

sudo apt install -y hugo # static site generator blog management
sudo apt install -y gist # github gists
sudo apt install -y texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
sudo apt install -y pandoc # export text files to other text files                                         
sudo apt install -y graphviz # graphing tools, including dot
sudo apt install -y git-filter-repo # useful git tool for selectively filtering git history 
sudo apt install -y shellcheck # https://www.shellcheck.net/ a shell script linter
sudo apt install -y fzf # fuzzy finder, also see fd, sd

# simulate pressing buttons, very useful script utility. dependency of tdrop.
sudo apt install -y xdotool
# appear & disappear windows
pushd $HOME/.setup/clones && hub clone https://github.com/noctuid/tdrop && cd tdrop && sudo make install && popd
# linter for dotenv files https://github.com/dotenv-linter/dotenv-linter
curl -sSfL https://git.io/JLbXn | sh -s -- -b "$HOME/.share/bin" v2.0.0

# airplay mirroring for ipad to linux
sudo apt install -y uxplay
sudo apt -y install gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-tools
