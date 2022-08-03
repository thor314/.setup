#!/bin/zsh
# text replacement tool https://espanso.org/docs/get-started/
# Note that installation is quite buggy at the moment 2022-05-30, rely on snap.
# pushd debs
# wget https://github.com/federico-terzi/espanso/releases/download/v2.1.5-beta/espanso-debian-x11-amd64.deb
# sudo apt install ./espanso-debian-x11-amd64.deb
# popd

# annoying, but fine
sudo snap install espanso --classic --channel=latest/edge
snap run espanso service register
snap run espanso start

