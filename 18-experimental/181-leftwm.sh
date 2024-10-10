#!/bin/bash
# LeftWM and leftwm-theme
cargo install leftwm
sudo cp $HOME/.config/leftwm/leftwm.desktop /usr/share/xsessions # link the xsession desktop file to make findable to display manager
pushd $HOME/.setup/clones 
hub clone https://github.com/leftwm/leftwm-theme && cd leftwm-theme
cargo build --release
sudo install -s -Dm755 ./target/release/leftwm-theme -t /usr/bin
hub clone git@github.com:leftwm/leftwm-config.git .. && cd ../leftwm-config
cargo build --release
cp target/release/leftwm-config $HOME/.cargo/bin
popd

