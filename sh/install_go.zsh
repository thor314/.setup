#!/bin/zsh

echo "installing Go, following instructions at: https://go.dev/doc/install"
echo "may have to update version..."

wget https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz
mv go1.18.2.linux-amd64.tar.gz $HOME/.files/setup/clones

export PATH=$PATH:/usr/local/go/bin
go version && echo Go installed

