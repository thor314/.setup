#!/bin/zsh

echo generate an ssh key 
ssh-keygen -t ed25519 -C thorck@protonmail.com
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
# 2 next lines deprecated. this will be done in gh auth login.
# cat $HOME/.zzsh/id_ed25519
# read "wait?Go enter your ssh key: https://github.com/settings/keys. "


# https://github.com/microsoft/Git-Credential-Manager-Core#linux-install-instructions
echo "This will run in the background, reducing 2FA weight when talking to github."
cd $HOME/.files/setup/debs
wget https://github.com/GitCredentialManager/git-credential-manager/releases/download/v2.0.696/gcmcore-linux_amd64.2.0.696.deb 
sudo dpkg -i gcmcore*
git-credential-manager-core configure
cd $HOME/.files/setup


echo "generate a gpg key. Choose 4096 when prompted."
gpg --full-generate-key
gpg --list-secret-keys --keyid-format LONG
read "pubkey?Enter your key id: " 
gpg --armor --export $pubkey
read "wait?copy paste your gpg pubkey to github: https://github.com/settings/keys. "

# github ssh and gpg help: https://docs.github.com/en/github-ae@latest/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
#
# deprecated: 
# run this command on each login to automate ssh key entry
# ssh-keygen -f /home/thor/.ssh/id_ed25519
