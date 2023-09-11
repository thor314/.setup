#!/bin/bash

# Python
sudo apt install -y python3-dev python3-pip python3-setuptools

# Rust
curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
rustup update && rustup toolchain install nightly && rustup default nightly
rustup target add wasm32-unknown-unknown --toolchain nightly # include wasm target
cargo install --locked trunk # wasm-bundler
cargo install --locked trunk && cargo install --locked wasm-bindgen-cli
rustup target add wasm32-unknown-unknown

# Go
pushd $HOME/.setup/clones
echo -e "\n\nInstall Golang: https://go.dev/dl/"
echo "Assuming extract to Downloads..."
read -p "press enter to continue"
if [[ -d /usr/local/go ]] ; then 
  sudo rm -rf /usr/local/go 
fi
sudo mv $HOME/Downloads/go /usr/local/go
export PATH=$PATH:/usr/local/go/bin && go version && echo Go installed
popd

# NVM/NPM/Node - deprecated: use fish plugin
# mkdir $HOME/.config/nvm
# wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# nvm install node
# npm install pnpm
