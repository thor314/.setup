#!/bin/bash
# Keybind settings for Gnome setup
# list the names of keys (not actually sure how to do this)
# gsettings list-keys org.gnome.settings-daemon.plugins.media-keys
# This script does not remove system default keybinds. To remove those, replace the keybind manually.

# Constants
MEDIA_KEYS="org.gnome.settings-daemon.plugins.media-keys"
KEYBIND_DIR="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

# Function to set a custom keybinding
set_custom_keybind() {
    local index=$1
    local name=$2
    local command=$3
    local binding=$4

    # TODO: removing system default keybindings seemed hard, so skip this for now
    if ! is_existing_keybind "$binding"; then 
        # remove the pre-existing keybind
        remove_keybind $binding
    fi

    echo "binding $name to $binding..."
    gsettings set "${MEDIA_KEYS}.custom-keybinding:${KEYBIND_DIR}/custom${index}/" name "${name}"
    gsettings set "${MEDIA_KEYS}.custom-keybinding:${KEYBIND_DIR}/custom${index}/" command "${command}"
    gsettings set "${MEDIA_KEYS}.custom-keybinding:${KEYBIND_DIR}/custom${index}/" binding "${binding}"
}

# if the keybind exists either in custom or on the system, return true
CUSTOM_BINDINGS=$(gsettings get "${MEDIA_KEYS}" custom-keybindings)
is_existing_custom_keybind() {
    local binding=$1
    local escaped_binding=$(printf '%s\n' "$binding" | sed 's/[]\/$*.^[]/\\&/g')  # Escape special characters for grep

    # Iterate over each custom binding path
    for path in ${CUSTOM_BINDINGS//,/ }; do
        # Trim leading and trailing characters and get the actual binding
        trimmed_path=$(echo $path | tr -d "'[],")
        actual_binding=$(gsettings get "${MEDIA_KEYS}.custom-keybinding:${trimmed_path}" binding)

        # Check if the actual binding matches the provided one
        if [[ "$actual_binding" == *"$escaped_binding"* ]]; then
            return 0
        fi
    done

    return 1
}
# Example usage
# is_existing_custom_keybind "<Super>d"

# Function to get the list of key names and their bindings from a schema, skipping over keys with empty bindings
get_key_bindings() {
    local schema=$1
    declare -A key_bindings

    for key_name in $(gsettings list-keys "$schema"); do
        local key_binding=$(gsettings get "$schema" "$key_name")

        # Skip keys with empty bindings
        if [[ "$key_binding" != "@as []" ]] && [[ "$key_binding" != "['']" ]] && [[ "$key_name" != "custom-keybindings" ]]; then
            key_bindings["$key_name"]="$key_binding"
        fi
    done

    echo $(declare -p key_bindings)
}

declare -A ALL_KEY_BINDINGS
SCHEMAS=("org.gnome.desktop.wm.keybindings" "org.gnome.settings-daemon.plugins.media-keys")
for schema in "${SCHEMAS[@]}"; do
    eval "$(get_key_bindings "$schema")"
    for key in "${!key_bindings[@]}"; do
        # echo "adding pair $key, ${key_bindings["$key"]}"
        ALL_KEY_BINDINGS["$key"]="${key_bindings["$key"]}"
    done
done
# echo "${ALL_KEY_BINDINGS[@]}"

is_existing_keybind() {
    local binding=$1

    # First, check custom keybindings
    if is_existing_custom_keybind "$binding"; then
        echo true
        return 0
    fi

    for key in "${!ALL_KEY_BINDINGS[@]}"; do
        # local key_binding=$(echo "${ALL_KEY_BINDINGS[$key]}" )
        local key_binding=$(echo "${ALL_KEY_BINDINGS[$key]}" | sed "s/^\['\(.*\)'\]$/\1/")
        echo does $key_binding match $binding
        if [[ "$key_binding" == "$binding" ]]; then
            echo true
            return 0
        fi
    done

    echo false
    return 1
}

# Example usage
# is_existing_keybind "<Super>m"

# remove the pre-existing keybind
remove_keybind() {
  # TODO: maybe one day
  local binding=$1
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


# Define custom keybindings
# Go go go
create_keybinds() {
    reset_keybindings
    create_slots 40
    echo "creating keybinds..." && sleep .3

    set_custom_keybind 0 "Alacritty tdrop" "$(tdrop_ alacritty false)" "<Super>g"
    set_custom_keybind 1 "tdrop Signal" "$(tdrop_ signal true org.signal.Signal)" "<Super>s"
    set_custom_keybind 2 "tdrop Discord" "$(tdrop_ discord true com.discordapp.Discord)" "<Super>d"
    set_custom_keybind 3 "tdrop Obsidian" "$(tdrop_ obsidian true md.obsidian.Obsidian)" "<Super>o"
    set_custom_keybind 4 "tdrop Firefox" "$(tdrop_ firefox false)" "<Super>f"
    set_custom_keybind 5 "tdrop Telegram" "$(tdrop_ telegram true org.telegram.desktop)" "<super><shift>t"
    set_custom_keybind 6 "Spotify" "$(tdrop_ spotify false)" "<Super><Shift>s"
    set_custom_keybind 7 "Alacritty" "alacritty" "<Super>t"

    # the following do not play nice w tdrop
    set_custom_keybind 10 "Feeling Finder" "flatpak run true codes.merritt.FeelingFinder" "<Super>e"
    set_custom_keybind 11 "Zotero" "flatpak run org.zotero.Zotero" "<Super>z"
    set_custom_keybind 12 "Code" "code" "<Super>c"

    set_custom_keybind 20 "Firefox Morning Tabs" "firefox $(join_array ' --new-tab ' "${morning_tabs[@]}")" "<Super><Shift>f"
    set_custom_keybind 21 "Firefox Pinned Tabs"  "firefox $(join_array ' --new-tab ' "${pinned_tabs[@]}")" "<Super><Shift>p"
    set_custom_keybind 22 "Firefox News Tabs"    "firefox $(join_array ' --new-tab ' "${news_tabs[@]}")" "<Super><Shift>n"

    SPOT_SEND="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2"
    set_custom_keybind 30 "Switch to Dvorak" "setxkbmap dvorak -option ctrl:nocaps" "menu"
    set_custom_keybind 31 "Switch to US" "setxkbmap us -option ctrl:nocaps" "<Shift>menu"
    set_custom_keybind 32 "Spotify Play/Pause Toggle" "$SPOT_SEND org.mpris.MediaPlayer2.Player.PlayPause" "<Super>space"
    # empty keybind intentional, only turn this on for laptop, not desktop
    set_custom_keybind 33 "Toggle Bluetooth" "bash $HOME/.files/scripts/bt.sh" "" 
    set_custom_keybind 34 "Skip Forward" "$SPOT_SEND org.mpris.MediaPlayer2.Player.Next" "<Super>period"
    set_custom_keybind 35 "Skip Backward" "$SPOT_SEND org.mpris.MediaPlayer2.Player.Previous" "<Super>comma"
    set_custom_keybind 36 "Skip Forward 20 Seconds" "playerctl position 20+" "<Super>a"
    set_custom_keybind 37 "Skip Backward 20 Seconds" "playerctl position 20-" "<Super><Shift>a"
    set_custom_keybind 38 "Suspend System" "systemctl suspend" "<Super>pause"

    echo "done" 
}

# TO TEST THIS SCRIPT:
# comment out this line and test commands
# create_keybinds


