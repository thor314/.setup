#!/bin/bash

# This will run in the background, reducing 2FA weight when talking to github
# https://github.com/microsoft/Git-Credential-Manager-Core#linux-install-instructions

# Download the .deb file
gcm_version=$( curl -s 'https://api.github.com/repos/git-ecosystem/git-credential-manager/releases/latest' |  jq -r ".tag_name" |  cut -c 2- )
wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v${gcm_version}/gcm-linux_amd64.${gcm_version}.deb
sudo dpkg -i ./gcm-linux_amd64.${gcm_version}.deb
git-credential-manager configure

# generate a gpg key use 4096 keylength
cat << EOF | gpg --batch --generate-key
%echo Generating a basic OpenPGP key
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: Thor Kamphefner 
Name-Email: thorck@pm.me
Expire-Date: 0
%commit
%echo Done
EOF

# copy public key string to clipboard
sudo apt install -y xclip
gpg --list-secret-keys --keyid-format LONG --with-colons | awk -F: '/sec:/ {print $5}' | xargs -I {} gpg --armor --export {} | xclip -selection clipboard
firefox --new-tab "https://github.com/settings/gpg/new"
read -p "the key string is in my clipboard. Tell github, and press enter to continue"

# set up ssh server
# todo: this section is a mess, need to refactor so I don't need to be on both machines
sudo apt install -y openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh 
echo -e "\n\nmy ip address is:"
echo -e "$(hostname -I | cut --delimiter=' ' -f1)\n\n"
echo "get shared key from another machine. From my other trusted machine, enter:"
echo "gpg --export-secret-keys thor-shared | ssh thor@IPADDRESS gpg --import"
