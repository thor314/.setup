#!/bin/bash
# Keybind settings for Gnome setup
# list the names of keys (not actually sure how to do this)
# gsettings list-keys org.gnome.settings-daemon.plugins.media-keys

# Constants
MEDIA_KEYS="org.gnome.settings-daemon.plugins.media-keys"
KEYBIND_DIR="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

# Function to set a custom keybinding
set_custom_keybind() {
    local index=$1
    local name=$2
    local command=$3
    local binding=$4
    gsettings set "${MEDIA_KEYS}.custom-keybinding:${KEYBIND_DIR}/custom${index}/" name "${name}"
    gsettings set "${MEDIA_KEYS}.custom-keybinding:${KEYBIND_DIR}/custom${index}/" command "${command}"
    gsettings set "${MEDIA_KEYS}.custom-keybinding:${KEYBIND_DIR}/custom${index}/" binding "${binding}"
}

# Register space for custom keybindings, use first argument for number of slots to create
create_slots() {
    echo "creating $1 slots..." && sleep .3
    keybindings=()
    for i in $(seq 0 $1 ); do
        keybindings+=("${KEYBIND_DIR}/custom${i}/")
    done
    #echo gsettings set "${MEDIA_KEYS}" custom-keybindings "[ $(printf "'%s', " "${keybindings[@]}" | sed 's/, $//') ]"
    gsettings set "${MEDIA_KEYS}" custom-keybindings "[ $(printf "'%s', " "${keybindings[@]}" | sed 's/, $//') ]"
    #echo "\n" gsettings set "${MEDIA_KEYS}" custom-keybindings "['${keybindings[@]}']" "\n"
    echo "done" 
}

morning_tabs=(
    "https://www.coingecko.com/en/portfolio"
    "https://eprint.iacr.org/days/7"
    "https://tweetdeck.twitter.com/"
    "https://github.com/thor314"
    #"https://feedly.com/"
    #"https://news.ycombinator.com/front"
    #"https://zkmesh.substack.com/"
)

morning_tabs=(
    "https://feedly.com/"
    "https://news.ycombinator.com/front"
    "https://zkmesh.substack.com/"
)

# List of tabs for Firefox Pinned keybinding
firefox_pinned=(
    "https://chat.openai.com/"
    "https://calendar.google.com/calendar/u/0/r/week"
    "https://mail.proton.me/u/0/inbox"
)

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
    create_slots 40

    echo "creating keybinds..." && sleep .3
    set_custom_keybind 0 "Alacritty tdrop" "$(tdrop_ alacritty false)" "<Super>G"
    set_custom_keybind 1 "tdrop Signal" "$(tdrop_ signal true org.signal.Signal)" "<Super>S"
    set_custom_keybind 2 "tdrop Discord" "$(tdrop_ discord true com.discordapp.Discord)" "<Super>D"
    set_custom_keybind 3 "tdrop Obsidian" "$(tdrop_ obsidian true md.obsidian.Obsidian)" "<Super>O"
    set_custom_keybind 4 "tdrop Firefox" "$(tdrop_ firefox false)" "<Super>F"
    set_custom_keybind 5 "tdrop Telegram" "$(tdrop_ telegram false)" "<super><shift>T"
    set_custom_keybind 6 "Spotify" "$(tdrop_ spotify false)" "<Super><Shift>S"
    set_custom_keybind 7 "Alacritty" "alacritty" "<Super>t"
    # the following do not play nice w tdrop
    set_custom_keybind 10 "Feeling Finder" "flatpak run true codes.merritt.FeelingFinder" "<Super>E"
    set_custom_keybind 11 "Zotero" "flatpak run org.zotero.Zotero" "<Super>Z"
    set_custom_keybind 12 "Code" "code" "<Super>C"

    set_custom_keybind 20 "Firefox Morning Tabs" "firefox $(join_array ' --new-tab ' "${morning_tabs[@]}")" "<Super><Shift>F"
    set_custom_keybind 21 "Firefox Pinned"       "firefox $(join_array ' --new-tab ' "${firefox_pinned[@]}")" "<Super><Shift>P"
    set_custom_keybind 22 "Firefox News"         "firefox $(join_array ' --new-tab ' "${firefox_news[@]}")" "<Super><Shift>N"

    SPOT_SEND="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2"
    set_custom_keybind 30 "Switch to Dvorak" "setxkbmap dvorak -option ctrl:nocaps" "Menu"
    set_custom_keybind 31 "Switch to US" "setxkbmap us -option ctrl:nocaps" "<Shift>Menu"
    set_custom_keybind 32 "Spotify Play/Pause Toggle" "$SPOT_SEND org.mpris.MediaPlayer2.Player.PlayPause" "<Super>space"
    # empty keybind intentional, only turn this on for laptop, not desktop
    set_custom_keybind 33 "Toggle Bluetooth" "bash $HOME/.files/scripts/bt.sh" "" 
    set_custom_keybind 34 "Skip Forward" "$SPOT_SEND org.mpris.MediaPlayer2.Player.Next" "<Super>period"
    set_custom_keybind 35 "Skip Backward" "$SPOT_SEND org.mpris.MediaPlayer2.Player.Previous" "<Super>comma"
    set_custom_keybind 36 "Skip Forward 20 Seconds" "playerctl position 20+" "<Super>A"
    set_custom_keybind 37 "Skip Backward 20 Seconds" "playerctl position 20-" "<Super><Shift>A"
    set_custom_keybind 38 "Suspend System" "systemctl suspend" "<Super>Pause"

    echo "done" 
}

# TO TEST THIS SCRIPT:
# comment out this line and test commands
create_keybinds

