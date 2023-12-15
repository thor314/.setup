#!/bin/bash
# Keybind settings for Gnome setup

# Constants
MEDIA_KEYS="org.gnome.settings-daemon.plugins.media-keys"
KEYBIND_DIR="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

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

# Register space for custom keybindings, use first argument for number of slots to create
create_slots() {
    echo "creating $1 slots..." && sleep .3
    keybindings=()
    for i in $(seq 0 $1 ); do
        keybindings+=("${KEYBIND_DIR}/custom${i}/")
    done
    gsettings set "${MEDIA_KEYS}" custom-keybindings "$(printf "'%s', " "${keybindings[@]}" | sed 's/, $//')"
    echo "done" 
}

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

# Function to generate a tdrop command with an option for Flatpak applications
tdrop_() {
    local app_name=$1
    local use_flatpak=$2
    local flatpak_name=$3

    if [ "$use_flatpak" = true ]; then
        echo "tdrop -ma -h 100% -w 50% -n ${app_name} --class=${app_name} flatpak run ${flatpak_name}"
    else
        echo "tdrop -ma -h 100% -w 50% -n ${app_name} ${app_name}"
    fi
}


# Define custom keybindings. 
create_keybinds() {
    # create enough slots for more ad-hoc keybinds in the future
    create_slots 30

    echo "creating keybinds..." && sleep .3
    set_custom_keybind 0 "Alacritty tdrop" "$(tdrop_ alacritty false)" "Super+G"
    set_custom_keybind 1 "Telegram" "$(tdrop_ telegram true org.telegram.desktop)" "Super+T"
    set_custom_keybind 2 "Signal" "$(tdrop_ signal true org.signal.Signal)" "Super+S"
    set_custom_keybind 3 "Discord" "$(tdrop_ discord true com.discordapp.Discord)" "Super+D"
    set_custom_keybind 4 "Obsidian" "$(tdrop_ obsidian true md.obsidian.Obsidian)" "Super+O"
    set_custom_keybind 5 "Firefox" "$(tdrop_ firefox false)" "Super+F"
    # feeling finder doesn't play nice with tdrop, sad face
    set_custom_keybind 6 "Feeling Finder" "$(tdrop_ feelingfinder true codes.merritt.FeelingFinder)" "Super+E"
    set_custom_keybind 7 "Alacritty" "alacritty" "Super+t"
    # zotero and code also do not play nice w tdrop
    set_custom_keybind 8 "Zotero" "flatpak run org.zotero.Zotero" "Super+Z"
    set_custom_keybind 9 "Code" "code" "Super+C"
    set_custom_keybind 10 "Switch to Dvorak" "setxkbmap dvorak -option ctrl:nocaps" "Menu"
    # todo: maybe bug, i think i switched spotify to flatpak
    set_custom_keybind 11 "Spotify" "$(tdrop_ spotify false)" "Super+Shift+S"
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
}

# TO TEST THIS SCRIPT:
# comment out this line and test commands
create_keybinds

