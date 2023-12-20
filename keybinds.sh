#!/bin/bash
# Keybind settings for Gnome setup
# list the names of keys (not actually sure how to do this)
# gsettings list-keys org.gnome.settings-daemon.plugins.media-keys
# TODO: this will not look to see if the new keybind conflicts with an old keybind and remove the old keybind

# Constants
MEDIA_KEYS="org.gnome.settings-daemon.plugins.media-keys"
KEYBIND_DIR="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

# Function to list existing custom keybindings with indices
# declare -A existing_keybindings
list_existing_keybinds() {
    existing_keybindings=()
    local bindings=$(gsettings get "${MEDIA_KEYS}" custom-keybindings)
    local index=0
    for binding in $bindings; do
        binding=$(echo $binding | tr -d '[],' | tr -d "'")
        # echo $binding
        if [ ! -z "$binding" ]; then
            local key=$(gsettings get "${binding}" binding)
            local key=$(gsettings get "${MEDIA_KEYS}.custom_keybinding:$binding" name)
            # /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/
            # name

            echo $key
    #         existing_keybindings["$key"]="${KEYBIND_DIR}/custom${index}"
    #         ((index++))
        fi
    done
    # echo "${existing_bindings[@]}"
}

EXISTING_KEYBINDS="$(list_existing_keybinds)"
echo $EXISTING_KEYBINDS
# EXISTING_KEYBINDS=list_existing_keybinds
# echo $EXISTING_KEYBINDS

# Function to list existing custom keybindings
list_existing_keybinds() {
    local bindings=$(gsettings get "${MEDIA_KEYS}" custom-keybindings)
    local existing_bindings=()
    for binding in $bindings; do
        # Remove brackets and commas from the string
        binding=$(echo $binding | tr -d '[],' | tr -d "'")
        if [ ! -z "$binding" ]; then
            local name=$(gsettings get "${binding}" name)
            local command=$(gsettings get "${binding}" command)
            local key=$(gsettings get "${binding}" binding)
            existing_bindings+=("$key:$command")
        fi
    done
    echo "${existing_bindings[@]}"
}

# EXISTING_KEYBINDS="$(list_existing_keybinds)"
# echo $EXISTING_KEYBINDS

# Was running into reproducibility issues, so added this to reset the keybinds directory first.
reset_keybindings() {
    echo "Resetting all custom keybindings..."
    gsettings set "${MEDIA_KEYS}" custom-keybindings "[]"
    echo "All custom keybindings have been reset."
}

# Function to set a custom keybinding
set_custom_keybind() {
    local index=$1
    local name=$2
    local command=$3
    local binding=$4

    # Remove existing keybinding if it conflicts
    if [[ -n "${existing_keybindings[$binding]}" ]]; then
        local conflicting_binding="${existing_keybindings[$binding]}"
        echo "Conflict detected for $name, $binding. Removing existing keybinding..."
        gsettings reset "${conflicting_binding}/name"
        gsettings reset "${conflicting_binding}/command"
        gsettings reset "${conflicting_binding}/binding"
    fi

    echo "binding $name to $binding..."
    gsettings set "${MEDIA_KEYS}.custom-keybinding:${KEYBIND_DIR}/custom${index}/" name "${name}"
    gsettings set "${MEDIA_KEYS}.custom-keybinding:${KEYBIND_DIR}/custom${index}/" command "${command}"
    gsettings set "${MEDIA_KEYS}.custom-keybinding:${KEYBIND_DIR}/custom${index}/" binding "${binding}"
}

# Register space for custom keybindings, use first argument for number of slots to create
create_slots() {
    echo "creating $1 slots..." && sleep .2
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

news_tabs=(
    "https://feedly.com/"
    "https://news.ycombinator.com/front"
    "https://zkmesh.substack.com/"
)

# List of tabs for Firefox Pinned keybinding
pinned_tabs=(
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
    reset_keybindings
    # create enough slots for more ad-hoc keybinds in the future
    create_slots 40
    list_existing_keybinds  # Update list of existing keybindings

    echo "creating keybinds..." && sleep .3
    set_custom_keybind 0 "Alacritty tdrop" "$(tdrop_ alacritty false)" "<Super>G"
    set_custom_keybind 1 "tdrop Signal" "$(tdrop_ signal true org.signal.Signal)" "<Super>S"
    set_custom_keybind 2 "tdrop Discord" "$(tdrop_ discord true com.discordapp.Discord)" "<Super>D"
    set_custom_keybind 3 "tdrop Obsidian" "$(tdrop_ obsidian true md.obsidian.Obsidian)" "<Super>O"
    set_custom_keybind 4 "tdrop Firefox" "$(tdrop_ firefox false)" "<Super>F"
    set_custom_keybind 5 "tdrop Telegram" "$(tdrop_ telegram true org.telegram.desktop)" "<super><shift>T"
    set_custom_keybind 6 "Spotify" "$(tdrop_ spotify false)" "<Super><Shift>S"
    set_custom_keybind 7 "Alacritty" "alacritty" "<Super>t"
    # the following do not play nice w tdrop
    set_custom_keybind 10 "Feeling Finder" "flatpak run true codes.merritt.FeelingFinder" "<Super>E"
    set_custom_keybind 11 "Zotero" "flatpak run org.zotero.Zotero" "<Super>Z"
    set_custom_keybind 12 "Code" "code" "<Super>C"

    set_custom_keybind 20 "Firefox Morning Tabs" "firefox $(join_array ' --new-tab ' "${morning_tabs[@]}")" "<Super><Shift>F"
    set_custom_keybind 21 "Firefox Pinned Tabs"  "firefox $(join_array ' --new-tab ' "${pinned_tabs[@]}")" "<Super><Shift>P"
    set_custom_keybind 22 "Firefox News Tabs"    "firefox $(join_array ' --new-tab ' "${news_tabs[@]}")" "<Super><Shift>N"

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
# create_keybinds


