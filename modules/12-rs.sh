#!/bin/bash
# Rust CLI tools

# ensure we have access to cargo
source $HOME/.cargo/env

# When possible, quick-install binaries, don't compile them 
# https://github.com/cargo-bins/cargo-binstall
# cargo install cargo-binstall # redundancy from 03; don't remove
# cargo binstall -y lsd # redundancy from 03; don't remove

# cli
cargo binstall -y ripgrep # better grep; https://github.com/BurntSushi/ripgrep
cargo binstall -y difftastic # diff w/ precargo installsion
cargo binstall -y cargo-generate # template generation
cargo binstall -y taplo-cli --locked # toml formatter, sometimes buggy
cargo binstall -y sd # search replace, nicer than sed
cargo binstall -y fd-find # find replacement
sudo ln -s /usr/bin/fdfind /usr/bin/fd # necessary for fish fzf plugin
cargo binstall -y tokei # code line counter
cargo binstall -y rusty-rain # fun
cargo binstall -y bottom --locked # top replacements
cargo install --git https://github.com/bvaisvil/zenith.git
#or: cargo install --features nvidia --git https://github.com/bvaisvil/zenith.git
# https://github.com/sxyazi/yazi?tab=readme-ov-file
cargo binstall -y  --locked yazi-fm yazi-cli
# https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
cargo binstall -y zoxide --locked

# cargo
cargo binstall -y cargo-update # update cargo binaries https://github.com/nabijaczleweli/cargo-update
cargo binstall -y cargo-udeps # show unused dependencies
cargo binstall -y cargo-deps # show dependency graph
# server deployment https://docs.shuttle.rs/getting-started/installation
cargo binstall -y cargo-shuttle 

# experimental
cargo binstall -y typos-cli # code comment typo-checker
cargo binstall -y du-dust # replace du, df; can also use deb-get; https://github.com/bootandy/dust
cargo binstall -y pipe-rename # file renamer tool
cargo binstall -y gitoxide # git modifiers https://github.com/Byron/gitoxide
cargo binstall -y zellij 
# deprecated 2024-10 
# cargo binstall -y texlab # tex langu server https://github.com/latex-lsp/texlab

# # my pride and joy
cargo binstall -y runi # https://crates.io/crates/runi

# cannot binstall diesel; deprecated 2024-05
# cargo install diesel_cli --no-default-features --features postgres # db orm cli

# wasm toolchain shit
rustup target add wasm32-unknown-unknown --toolchain nightly # include wasm target
cargo binstall -y --locked trunk # wasm bundler
cargo binstall -y --locked wasm-bindgen-cli
rustup target add wasm32-unknown-unknown

