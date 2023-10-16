#!/bin/bash

# Python
sudo apt install -y python3-dev python3-pip python3-setuptools

# Rust
# curl https://sh.rustup.rs -sSf | sh -s -- -y # interactive
curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable -y
source $HOME/.cargo/env
rustup update && rustup toolchain install nightly && rustup default nightly
rustup target add wasm32-unknown-unknown --toolchain nightly # include wasm target
cargo install --locked trunk # wasm-bundler
cargo install --locked trunk && cargo install --locked wasm-bindgen-cli
rustup target add wasm32-unknown-unknown

# Go
url=$(curl -s https://go.dev/dl/ | grep -o 'href="/dl/go[0-9]*\.[0-9]*\.[0-9]*\.linux-amd64\.tar\.gz"' | awk -F'"' '{print "https://go.dev"$2}' | tail -n 1)
# Download the package using wget
wget $url
# Extract the tarball
tar -xzf go*.linux-amd64.tar.gz
# Move the extracted folder to /usr/local (requires sudo)
sudo mv go /usr/local
export PATH=$PATH:/usr/local/go/bin && go version && echo Go installed
rm go.*.tar.gz

# NVM/NPM/Node - deprecated: use fish plugin
# mkdir $HOME/.config/nvm
# wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# nvm install node
# npm install pnpm
