#!/bin/bash
# Obtain this script:
# git clone https://github.com/thor314/.setup.git && cd .setup
# then copy-paste, fixing any bugs as they arise

set -euo pipefall # https://wizardzines.com/comics/bash-errors/
PATH=$PATH:"/home/thor/bin/cargo:/home/thor/bin/local:/home/thor/bin/npm:/home/thor/bin/share"

./00-update-apt.sh
./01-vim.sh
./02-package-managers.sh
./03-languages.sh
./04-ssh-gpg.sh
./05-fish.sh
./051-alacritty.sh
./052-fisher.sh
./06-clone-home.sh
./07-dotbot.sh
./08-cron.sh
./09-fonts.sh
./10-cli-common.sh
./11-cli-py.sh
./111-cli-sage.sh
./12-cli-rs.sh # todo unmet dependencies
./121-bat.sh
./13-cli-node.sh
#./18-cli-window-manager.sh
#./181-leftwm.sh
#./182-picom.sh
#./183-rofi.sh
./19-cli-experimental.sh
./20-gui-common.sh

