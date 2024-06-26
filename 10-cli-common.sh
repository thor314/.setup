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
sudo apt install -y feh # set background image

# simulate pressing buttons, very useful script utility. dependency of tdrop.
sudo apt install -y xdotool
# appear & disappear windows
sudo apt install gawk -y # tdrop dependency
pushd $HOME/.setup/clones && hub clone https://github.com/noctuid/tdrop && cd tdrop && sudo make install && popd
# linter for dotenv files https://github.com/dotenv-linter/dotenv-linter
curl -sSfL https://git.io/JLbXn | sh -s -- -b "$HOME/.share/bin" v2.0.0

# airplay mirroring for ipad to linux; note uxplay sometimes requires `uxplay -avdec` to correctly decode ipad data
sudo apt install -y uxplay
sudo apt -y install gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-tools

# docker is everyone's favorite software to install
sudo apt update
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
echo "Verifying Docker installation..."
sudo systemctl status docker
echo "Docker installation completed."
# run docker as thor, not sudo:
sudo usermod -aG docker $USER

# zola
git clone https://github.com/barnumbirr/zola-debian $HOME/.setup/clones
sudo sh $HOME/.setup/clones/zola-debian/build.sh
sudo dpkg -i $HOME/.setup/clones/zola-debian/target/zola*.deb
