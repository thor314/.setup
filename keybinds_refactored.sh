#!/bin/bash
# Keybind settings for Gnome setup
# todo: test this script

# Constants
MEDIA_KEYS="org.gnome.settings-daemon.plugins.media-keys"
KEYBIND_DIR="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
MAX_BINDINGS=21  # Maximum number of custom keybindings


# Function to set a custom keybinding
set_custom_keybind() {
    local index=$1
    local name=$2
    local command=$3
    local binding=$4

    gsettings set "${MEDIA_KEYS}:${KEYBIND_DIR}/custom${index}/" name "${name}"
    gsettings set "${MEDIA_KEYS}:${KEYBIND_DIR}/custom${index}/" command "${command}"
    gsettings set "${MEDIA_KEYS}:${KEYBIND_DIR}/custom${index}/" binding "${binding}"
}

# Register space for custom keybindings
echo "creating $MAX_BINDINGS slots..." && sleep .3
keybindings=()
for i in $(seq 0 $MAX_BINDINGS); do
    keybindings+=("${KEYBIND_DIR}/custom${i}/")
done
gsettings set "${MEDIA_KEYS}" custom-keybindings "$(printf "'%s', " "${keybindings[@]}" | sed 's/, $//')"
echo "done" 

# List of tabs for Firefox Tabs keybinding
firefox_tabs=(
    "https://www.coingecko.com/en/portfolio"
    "https://eprint.iacr.org/days/7"
    "https://feedly.com/"
    "https://news.ycombinator.com/front"
    "https://tweetdeck.twitter.com/"
    "https://zkmesh.substack.com/"
    "https://github.com/thor314"
)

# List of tabs for Firefox Pinned keybinding
firefox_pinned=(
    "https://chat.openai.com/"
    "https://calendar.google.com/calendar/u/0/r/week"
    "https://mail.proton.me/u/0/inbox"
)
    # "https://claude.ai/chats"
    # "https://assistant.google.com/tasks?otzr=1"

# Function to join array elements into a string
join_array() {
    local IFS="$1"; shift; echo "$*";
}

# Define custom keybindings
echo "creating keybinds..." && sleep .3
set_custom_keybind 0 "Alacritty tdrop" "tdrop -ma -h 100% -w 50% alacritty" "Super+G"
set_custom_keybind 1 "Telegram" "tdrop -ma -h 100% -w 50% -n telegram --class=telegram flatpak run org.telegram.desktop" "Super+T"
set_custom_keybind 2 "Signal" "tdrop -ma -h 100% -w 50% -n signal --class=signal flatpak run org.signal.Signal" "Super+S"
set_custom_keybind 3 "Discord" "tdrop -ma -h 100% -w 50% -n discord --class=discord flatpak run com.discordapp.Discord"
"Super+D"
set_custom_keybind 4 "Obsidian" "tdrop -ma -h 100% -w 50% -n obsidian --class=obsidian flatpak run md.obsidian.Obsidian"
"Super+O"
set_custom_keybind 5 "Firefox" "tdrop -ma -h 100% -w 50% firefox" "Super+F"
set_custom_keybind 6 "Feeling Finder" "tdrop -ma -h 100% -w 50% -n feelingfinder --class=feelingfinder flatpak run
codes.merritt.FeelingFinder" "Super+E"
set_custom_keybind 7 "Alacritty" "alacritty" "Super+t"
set_custom_keybind 8 "Zotero" "flatpak run org.zotero.Zotero" "Super+Z"
set_custom_keybind 9 "Code" "code" "Super+C"
set_custom_keybind 10 "Switch to Dvorak" "setxkbmap dvorak -option ctrl:nocaps" "Menu"
set_custom_keybind 11 "Spotify" "tdrop -ma -h 100% -w 50% -n spotify spotify" "Super+Shift+S"
set_custom_keybind 12 "Switch to US" "setxkbmap us -option ctrl:nocaps" "Shift+Menu"

set_custom_keybind 13 "Firefox Tabs" "firefox $(join_array ' --new-tab ' "${firefox_tabs[@]}")" "Super+B"
set_custom_keybind 14 "Firefox Pinned" "firefox $(join_array ' --new-tab ' "${firefox_pinned[@]}")" "Super+Shift+P"
#set_custom_keybind 13 "Firefox Tabs" "firefox --new-tab 'https://www.coingecko.com/en/portfolio' --new-tab 'https://eprint.iacr.org/days/7' --new-tab 'https://feedly.com/' --new-tab 'https://news.ycombinator.com/front' --new-tab 'https://tweetdeck.twitter.com/' --new-tab 'https://zkmesh.substack.com/' --new-tab 'https://github.com/thor314'" "Super+B"
#set_custom_keybind 14 "Firefox Pinned" "firefox --new-tab 'https://claude.ai/chats' --new-tab 'https://chat.openai.com/' --new-tab 'https://assistant.google.com/tasks?otzr=1' --new-tab 'https://calendar.google.com/calendar/u/0/r/week' --new-tab 'https://mail.proton.me/u/0/inbox'" "Super+Shift+P"

set_custom_keybind 15 "Spotify Play/Pause Toggle" "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause" "Super+Space"
set_custom_keybind 16 "Toggle Bluetooth" "bash $HOME/.files/scripts/bt.sh" "Super+Shift+B"
set_custom_keybind 17 "Skip Forward" "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next" "Super+."
set_custom_keybind 18 "Skip Backward" "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous" "Super+,"
set_custom_keybind 19 "Skip Forward 20 Seconds" "playerctl position 20+" "Super+a"
set_custom_keybind 20 "Skip Backward 20 Seconds" "playerctl position 20-" "Super+Shift+A"
set_custom_keybind 21 "Suspend System" "systemctl suspend" "Super+Pause"

echo "done" 
