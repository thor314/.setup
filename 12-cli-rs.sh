#!/bin/bash
# Rust CLI tools

source $HOME/.cargo/env
cargo install ripgrep # better grep
# cargo install zellij # commented 2024-01-25
cargo install du-dust # replace du, df
cargo install bottom --locked # top replacements
cargo install --git https://github.com/bvaisvil/zenith.git
cargo install difftastic # diff w/ precargo installsion
cargo install pipe-rename # file renamer tool
sudo apt -y install libssl-dev # cgen dep
cargo install cargo-generate
cargo install rusty-rain
cargo install taplo-cli --locked # toml formatter, sometimes buggy
cargo install sd # search replace, nicer than sed
cargo install fd-find # find replacement
sudo ln -s /usr/bin/fdfind /usr/bin/fd # necessary for fish fzf plugin
cargo install texlab # tex langu server https://github.com/latex-lsp/texlab
# Quick install binaries, don't compile them https://github.com/cargo-bins/cargo-quickinstall 
cargo install cargo-quickinstall
cargo quickinstall gitoxide # git modifiers https://github.com/Byron/gitoxide

cargo install cargo-binstall
cargo binstall cargo-shuttle # api deployment tool https://docs.shuttle.rs/getting-started/installation

# option to install more bat tools
# https://github.com/eth-p/bat-extras/blob/master/README.md#installation
sudo apt install bat -y
if [ ! -d "$HOME/.local/bin" ]; then
  mkdir -p ~/.local/bin
fi
ln -s /usr/bin/batcat ~/.local/bin/bat

