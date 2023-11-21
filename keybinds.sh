#!/bin/bash
# keybind settings for Gnome

# Unbind conflicting hotkeys (unsure how), needs debugging
# gsettings set org.gnome.shell.extensions.pop-shell float-window '[]'

# 2023-11-03 debug note: tried to refactor with MEDIA_KEYS and BIND_DIR, as well as multi-line strings. May cause
# issues, will have to test next install.

MEDIA_KEYS=org.gnome.settings-daemon.plugins.media-keys.custom-keybinding
KEYBIND_DIR=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings

# todo: do this but not shitty
# Register space for plenty of custom keybindings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/', 
  '/org/gnome/settings-daemon/plugins.media-keys/custom-keybindings/custom4/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom11/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom12/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom13/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom14/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom15/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom16/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom17/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom18/', 
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom19/' ]"

# todo figure out a nice way to do this when I run the script next
# kbnd() {
#   if [ $# -ne 4 ]; then
#     echo "Usage: set_custom_keybind <keybind_name> <name> <command> <binding>"
#     return 1
#   fi

#   local keybind_name=$1
#   local name=$2
#   local command=$3
#   local binding=$4
#   local MEDIA_KEYS="org.gnome.settings-daemon.plugins.media-keys"
#   local KEYBIND_DIR="custom-keybindings"

#   gsettings set "$MEDIA_KEYS:$KEYBIND_DIR/$keybind_name/" name "$name"
#   gsettings set "$MEDIA_KEYS:$KEYBIND_DIR/$keybind_name/" command "$command"
#   gsettings set "$MEDIA_KEYS:$KEYBIND_DIR/$keybind_name/" binding "$binding"
# }

# tdrop hotkeys
# Alacritty (Super+G)
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom0/ name 'Alacritty tdrop'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom0/ command 'tdrop -ma -h 100% -w 50% alacritty'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom0/ binding 'Super+G'

# Telegram (Super+T)
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom1/ name 'Telegram'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom1/ command 'tdrop -ma -h 100% -w 50% -n telegram --class=telegram flatpak run org.telegram.desktop'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom1/ binding 'Super+T'

# Signal (Super+S)
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom2/ name 'Signal'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom2/ command 'tdrop -ma -h 100% -w 50% -n signal --class=signal flatpak run org.signal.Signal'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom2/ binding 'Super+S'

# Discord (Super+D)
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom3/ name 'Discord'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom3/ command 'tdrop -ma -h 100% -w 50% -n discord --class=discord flatpak run com.discordapp.Discord'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom3/ binding 'Super+D'

# Obsidian (Super+O)
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom4/ name 'Obsidian'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom4/ command 'tdrop -ma -h 100% -w 50% -n obsidian --class=obsidian flatpak run md.obsidian.Obsidian'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom4/ binding 'Super+O'

# Firefox (Super+F)
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom5/ name 'Firefox'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom5/ command 'tdrop -ma -h 100% -w 50% firefox'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom5/ binding 'Super+F'

# Feeling Finder (Super+E)
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom6/ name 'Feeling Finder'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom6/ command 'tdrop -ma -h 100% -w 50% -n feelingfinder --class=feelingfinder flatpak run codes.merritt.FeelingFinder'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom6/ binding 'Super+E'

# Spotify (Super+Shift+S)
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom11/ name 'Spotify' 
#gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom11/ command 'tdrop -ma -h 100% -w 50% -n spotify --class=spotify flatpak run com.spotify.Client' 
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom11/ command 'tdrop -ma -h 100% -w 50% -n spotify spotify'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom11/ binding 'Super+Shift+S'


# Normal hotkeys
# Alacritty (Super+T)
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom7/ name 'Alacritty'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom7/ command 'alacritty'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom7/ binding 'Super+t'

# Zotero (Super+Z)
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom8/ name 'Zotero'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom8/ command 'flatpak run org.zotero.Zotero'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom8/ binding 'Super+Z'

# Code (Super+C)
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom9/ name 'Code'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom9/ command 'code'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom9/ binding 'Super+C'


# Keyboard layout switching
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom12/ name 'Switch to Dvorak'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom12/ command 'setxkbmap dvorak -option ctrl:nocaps'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom12/ binding 'Menu'

gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom13/ name 'Switch to US'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom13/ command 'setxkbmap us -option ctrl:nocaps'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom13/ binding 'Shift+Menu'

# Misc commands
## Open Firefox with multiple tabs (Super+B)
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom10/ name 'Firefox Tabs'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom10/ command 'firefox --new-tab "https://www.coingecko.com/en/portfolio" --new-tab "https://eprint.iacr.org/days/7" --new-tab "https://feedly.com/" --new-tab "https://news.ycombinator.com/front" --new-tab "https://tweetdeck.twitter.com/" --new-tab "https://zkmesh.substack.com/" --new-tab "https://github.com/thor314"'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom10/ binding 'Super+B'

gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom14/ name 'Firefox Pinned'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom14/ command 'firefox -new-tab "https://claude.ai/chats" 
-new-tab "https://chat.openai.com/" 
-new-tab "https://assistant.google.com/tasks?otzr=1" 
-new-tab "https://calendar.google.com/calendar/u/0/r/week" \
-new-tab "https://mail.proton.me/u/0/inbox"'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom14/ binding 'Super+Shift+P'

gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom15/ name 'Spotify Play/Pause Toggle'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom15/ command 'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom15/ binding 'Super+ '

gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom16/ name 'Toggle bluetooth'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom16/ command 'bash $HOME/.files/scripts/bt.sh'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom16/ binding 'Super+Shift+B'

gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom17/ name 'skip forward'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom17/ command 'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom17/ binding 'Super+.'

gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom18/ name 'skip backward'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom18/ command 'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom18/ binding 'Super+,'

gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom19/ name 'skip forward 20 seconds'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom19/ command 'playerctl position 20+'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom19/ binding 'Super+a'

gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom20/ name 'skip backward 20 seconds'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom20/ command 'playerctl position 20-'
gsettings set $MEDIA_KEYS:$KEYBIND_DIR/custom20/ binding 'Super+Shift+A'
