#!/bin/zsh
# Script written on 2022-05-29 by Thor Kamphefner to set keybinds with gsettings
# Don't use this, it's crap. Use the python script instead.

# How many keybinds?
N=16
# Put keybindings here
k0=("keyboard dvorak nocaps" "Menu" "setxbmap dvorak -option nocaps")  
k1=("launch code" "<Super>c" "code") 
k2=("dropdown firefox" "<Shift><Super>f" "tdrop -ma -h \"100%\" -w \"50%\" firefox")

mkeys="org.gnome.settings-daemon.plugins.media-keys"
_locstr="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom"
_ck="$mkeys.custom-keybinding:$_locstr"
M="$(expr $N - 1)"

# Create spaces for $N keybindings, emulating the command:
# gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"
locations=""
for i in $(seq 0 $M); do
  locations+="'$_locstr$i/', "
done
locations+="'$_locstr$N/' "
gsettings set $mkeys custom-keybindings "[$locations]"


# issue commands. Have to paste 4 lines each time, kinda gross.
ck="${_ck}0/"
gsettings set $ck name    $k0[1]
gsettings set $ck binding $k0[2]
gsettings set $ck command $k0[3]
ck="${_ck}1/"
gsettings set $ck name    $k1[1]
gsettings set $ck binding $k1[2]
gsettings set $ck command $k1[3]
ck="${_ck}2/"
gsettings set $ck name    $k2[1]
gsettings set $ck binding $k2[2]
gsettings set $ck command $k2[3]

# test with:
# i=0
# ck="${_ck}$i/"
# gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings
# gsettings list-recursively $ck
