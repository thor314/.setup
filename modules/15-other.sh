#!/bin/bash

# gh
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

# docker is everyone's favorite software to install
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o docker-archive-keyring.gpg
sudo mv docker-archive-keyring.gpg /usr/share/keyrings/
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release
echo "Setting up the Docker repository..."
echo \
"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "Updating package database..."

# Install Docker CE
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
# echo "Verifying Docker installation..."
# sudo systemctl status docker
echo "Docker installation completed."
# run docker as thor, not sudo:
sudo usermod -aG docker $USER

# xdotool: simulate pressing buttons in scripts. 
sudo apt install -y xdotool gawk # tdrop dependencies 
git clone https://github.com/noctuid/tdrop && cd tdrop && sudo make install && cd .. && rm tdrop -rf

# linter for dotenv files https://github.com/dotenv-linter/dotenv-linter
curl -sSfL https://git.io/JLbXn | sh -s -- -b "$HOME/.share/bin" v2.0.0

# espanso, a customizeable and platform agnostic text expander
wget https://github.com/federico-terzi/espanso/releases/download/v2.1.8/espanso-debian-x11-amd64.deb
sudo apt install ./espanso-debian-x11-amd64.deb -y
espanso service register
espanso start
rm espanso-*

wget https://github.com/leona/helix-gpt/releases/download/0.34/helix-gpt-0.34-x86_64-linux.tar.gz \
  -O /tmp/helix-gpt.tar.gz \
  && tar -zxvf /tmp/helix-gpt.tar.gz \
  && mv helix-gpt-0.34-x86_64-linux ~/.local/bin/helix-gpt \
  && chmod +x ~/.local/bin/helix-gpt

# Broken installs:
# zola, an SSG written in Rust (reqires docker)
# git clone https://github.com/barnumbirr/zola-debian 
# sudo sh zola-debian/build.sh
# sudo dpkg -i zola-debian/target/zola*.deb
# rm zola-debian -r

# # just dependency: makedeb
# # mkdeb, a simplicity focused pcakaging tool for debian archives
# # https://www.makedeb.org/
# bash -ci "$(wget -qO - 'https://shlink.makedeb.org/install')"

# # just, a command runner
# # https://github.com/casey/just#shell-completion-scripts
# git clone https://mpr.makedeb.org/just
# pushd just
# makedeb -si
# sudo dpkg -i just_*_amd64.deb
# popd
# rm -rf just

