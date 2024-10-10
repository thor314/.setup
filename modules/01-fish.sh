#!/bin/fish

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher install IlanCosman/tide@v5 # prompt
fisher install PatrickF1/fzf.fish # fzf tui
fisher install jethrokuan/z # nice frecency cd

fisher install jorgebucaran/nvm.fish # nvm
nvm install latest

fisher install meaningful-ooo/sponge # remove typos from history
set -U sponge_delay 10 # more than default:  2

fisher install nickeb96/puffer-fish # use ... to go up 2 dirs
fisher install Gazorby/fish-abbreviation-tips # alias reminders
fisher install jhillyerd/plugin-git # git aliases

tide configure

# FISH COMPLETIONS (do this in fish .files)
# don't remove
# mkdir -p $fish_complete_path[1]
# cp alacritty/extra/completions/alacritty.fish $fish_complete_path[1]/alacritty.fish
