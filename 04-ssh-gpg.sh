#!/bin/bash

# can't clone correctly until we authenticate to github
echo -e "\n\nGenerate an ssh key:"
ssh-keygen -t ed25519 -C thorck@pm.me
ssh-add
# Maybe redundant:
echo -e "\ntell github about your new ssh key:\n"
cat $HOME/.ssh/id_ed25519.pub

# This will run in the background, reducing 2FA weight when talking to github
# https://github.com/microsoft/Git-Credential-Manager-Core#linux-install-instructions
echo -e "\n\nGo get the deb file: https://github.com/git-ecosystem/git-credential-manager/releases/tag/v2.0.935"
read -p "Install with Eddy, then press enter to continue"
git-credential-manager configure

# github interaction tools
sudo apt install -y gh
sudo apt install -y hub
gh auth login

# generate a gpg key use 4096 keylength
gpg --full-generate-key
gpg --list-secret-keys
echo "call gpg --armor --export PUBKEYSTRING"
echo -e "\n\nTell github about your new gpg key..."
read -p "press enter to continue"

# set up ssh server
sudo apt install -y openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh 
echo -e "\n\nmy ip address is:"
echo -e "$(hostname -I | cut --delimiter=' ' -f1)\n\n"
echo "get shared key from another machine. From my other trusted machine, enter:"
echo "gpg --export-secret-keys thor-shared | ssh thor@IPADDRESS gpg --import"
echo "if that worked, I should be able to open my secrets file. Add my ip to env vars".
read -p "press enter to continue"
vi $HOME/.private/secrets.gpg


