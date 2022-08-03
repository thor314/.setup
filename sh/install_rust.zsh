#!/bin/zsh
echo installing Rust...
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup update && rustup toolchain install nightly && rustup default nightly
rustup target add wasm32-unknown-unknown --toolchain nightly # include wasm target

cargo install cargo-tarpaulin # code coverage

echo Rust installed

# install RA in VScode instead
# git clone https://github.com/rust-analyzer/rust-analyzer.git
# pushd rust-analyzer
# cargo xtask install --server
# popd

