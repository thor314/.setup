#!/bin/bash
# history started 2024-10
read -p "are you sure you want to run an unsorted script of random nonsense? Ctrl-C to quit, enter to proceed"

# todo: move to home.sh and fine-tune
hub clone --recursive rust-playground
hub clone --recursive python-playground
hub clone --recursive web-playground

# protonmail gui deprecated until they fix their notification bug
pushd debs && wget https://proton.me/download/mail/linux/ProtonMail-desktop-beta.deb && sudo dpkg -i ProtonMail*.deb && popd 

