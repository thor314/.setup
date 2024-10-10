#!/bin/bash
# Keybind settings for Gnome setup
# list the names of keys (not actually sure how to do this)
# gsettings list-keys org.gnome.settings-daemon.plugins.media-keys
# This script does not remove system default keybinds. To remove those, replace the keybind manually.

# Constants
MEDIA_KEYS="org.gnome.settings-daemon.plugins.media-keys"
KEYBIND_DIR="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
CUSTOM_BINDS=$(gsettings get "${MEDIA_KEYS}" custom-keybindings)

# Function to set a custom keybinding
set_custom_keybind() {
    local index=$1
    local name=$2
    local command=$3
    local bind=$4

    echo "binding $name to $bind..."
    gsettings set "${MEDIA_KEYS}.custom-keybinding:${KEYBIND_DIR}/custom${index}/" name "${name}"
    gsettings set "${MEDIA_KEYS}.custom-keybinding:${KEYBIND_DIR}/custom${index}/" command "${command}"
    gsettings set "${MEDIA_KEYS}.custom-keybinding:${KEYBIND_DIR}/custom${index}/" binding "${bind}"
}

# Register space for custom keybinds, use first argument for number of slots to create
create_slots() {
    echo "creating $1 slots..." && sleep .2
    keybinds=()
    for i in $(seq 0 $1 ); do
        keybinds+=("${KEYBIND_DIR}/custom${i}/")
    done
    gsettings set "${MEDIA_KEYS}" custom-keybindings "[ $(printf "'%s', " "${keybinds[@]}" | sed 's/, $//') ]"
    echo "done" 
}

# Firefox tab lists
morning_tabs=(
    "https://www.coingecko.com/en/portfolio"
    "https://eprint.iacr.org/days/7"
    "https://tweetdeck.twitter.com/"
    "https://github.com/thor314"
)

news_tabs=(
    "https://feedly.com/"
    "https://news.ycombinator.com/front"
    "https://zkmesh.substack.com/"
)

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

# Go go go
create_keybinds() {
    create_slots 40
    echo "creating keybinds..." && sleep .3

    set_custom_keybind 0 "Alacritty tdrop" "$(tdrop_ alacritty false)" "<Super>g"
    set_custom_keybind 1 "tdrop Signal" "$(tdrop_ signal true org.signal.Signal)" "<Super>s"
    set_custom_keybind 2 "tdrop Discord" "$(tdrop_ discord true com.discordapp.Discord)" "<Super>d"
    set_custom_keybind 3 "tdrop Obsidian" "$(tdrop_ obsidian true md.obsidian.Obsidian)" "<Super>o"
    set_custom_keybind 4 "tdrop Firefox" "$(tdrop_ firefox false)" "<Super>f"
    set_custom_keybind 5 "tdrop Telegram" "$(tdrop_ telegram true org.telegram.desktop)" "<super><shift>t"
    set_custom_keybind 6 "tdrop Spotify" "$(tdrop_ spotify false)" "<Super><Shift>s"
    set_custom_keybind 7 "Alacritty" "alacritty" "<Super>t"
    set_custom_keybind 8 "tdrop Slack" "$(tdrop_ slack true com.slack.Slack)" "<Super>w"
    set_custom_keybind 9 "tdrop proton-mail" "tdrop proton-mail" "<Super><Shift>m"


    # the following do not play nice w tdrop
    set_custom_keybind 10 "Feeling Finder" "flatpak run true codes.merritt.FeelingFinder" "<Super>e"
    set_custom_keybind 11 "Zotero" "flatpak run org.zotero.Zotero" "<Super>z"
    set_custom_keybind 12 "Code" "code" "<Super>c"
    set_custom_keybind 13 "Calendar" "gnome-calendar" "<Super><Shift>c"

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
create_keybinds


# is_existing_keybind() {
#     local bind=$1

#     # First, check custom keybinds
#     if is_existing_custom_keybind "$bind"; then
#         return 0
#     fi

#     for key in "${!ALL_KEY_BINDINGS[@]}"; do
#         local key_bind=$(echo "${ALL_KEY_BINDINGS[$key]}" | sed "s/^\['\(.*\)'\]$/\1/")
#         if [[ "$key_bind" == "$bind" ]]; then
#             echo $key_bind, $key matches $bind for system keybinds
#             return 0
#         fi
#     done

#     echo $bind is not set in system keybinds
#     return 1
# }

# # if the keybind exists either in custom or on the system, return true
# is_existing_custom_keybind() {
#     local bind=$1
#     local escaped_bind=$(printf '%s\n' "$bind" | sed 's/[]\/$*.^[]/\\&/g')  # Escape special characters for grep

#     # Iterate over each custom bind path
#     for path in ${CUSTOM_BINDINGS//,/ }; do
#         # Trim leading and trailing characters and get the actual bind
#         trimmed_path=$(echo $path | tr -d "'[],")
#         actual_bind=$(gsettings get "${MEDIA_KEYS}.custom-keybinding:${trimmed_path}" bind)
#         # echo $actual_bind, $escaped_bind

#         # Check if the actual bind matches the provided one
#         if [[ "$actual_bind" == *"$escaped_bind"* ]]; then
#             echo $escaped_bind already set at $actual_bind
#             return 0
#         fi
#     done

#     echo $bind is not set in custom keybinds
#     return 1
# }
# # Example usage
# # is_existing_custom_keybind "<Super>d"

# get_keybinds(){
#     SCHEMAS=("org.gnome.desktop.wm.keybindings" "org.gnome.settings-daemon.plugins.media-keys")
#     declare -A ALL_KEY_BINDS
#     for schema in "${SCHEMAS[@]}"; do
#         eval "$(get_key_binds_for_schema "$schema")"
#         for key in "${!key_binds[@]}"; do
#             # echo "adding pair $key, ${key_binds["$key"]}"
#             ALL_KEY_BINDINGS["$key"]="${key_binds["$key"]}"
#         done
#     done

#     echo "$(declare -p ALL_KEY_BINDS)"
# }

# # Function to get the list of key names and their binds from a schema, skipping over keys with empty binds
# get_key_binds_for_schema() {
#     local schema=$1
#     declare -A key_binds

#     for key_name in $(gsettings list-keys "$schema"); do
#         local key_bind=$(gsettings get "$schema" "$key_name")

#         # Skip keys with empty binds
#         if [[ "$key_bind" != "@as []" ]] && [[ "$key_bind" != "['']" ]] && [[ "$key_name" != "custom-keybindings" ]]; then
#             key_binds["$key_name"]="$key_bind"
#         fi
#     done

#     echo $(declare -p key_binds)
# }

# # remove the pre-existing keybind
# remove_keybind() {
#   # TODO: maybe one day
#   local command=$1
#   local bind=$2
#   echo removing $command at $bind
# }
