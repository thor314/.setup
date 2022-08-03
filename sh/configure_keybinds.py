import os

# How many keybinds?
# Put keybindings here
binds=[
    ['kbd us', '<Shift>Menu', 'setxkbmap us'],
    ['kbd dvorak nocaps', 'Menu', 'setxkbmap dvorak -option ctrl:nocaps']  ,
    ['rofi emoji', '<Super>e', 'rofi -show emoji -modi emoji'],
    ['launch alacritty', '<Super>t', 'alacritty'],
    ['launch code', '<Super>c', 'code'], 
    ['launch discord', '<Super>d', 'discord'],
    ['launch firefox', '<Super>f', 'firefox'],
    ['launch obsidian', '<Super>o', 'flatpak run md.obsidian.Obsidian'],
    ['launch signal', '<Super>s', 'signal-desktop'],
    ['launch telegram', '<Shift><Super>t', 'telegram'],
    ['dropdown alacritty', '<Super>g', 'tdrop -ma -h \"100%\" -w \"100%\" alacritty'],
    ['dropdown firefox', '<Shift><Super>f', 'tdrop -ma -h \"100%\" -w \"50%\" firefox'],
    ['dropdown obsidian', '<Shift><Super>o', 'tdrop -ma -h \"100%\" -n obsidian --class=obsidan flatpak run md.obsidian.Obsidian'],
    ['screenshot to last.png', '<Primary>Print', 'maim -u -s ~/img/last.png'],
    ['screenshot to clip', '<Super>Print', 'gnome-screenshot -a -c'],
    ['nmcli connect to Å', '<Shift><Super>w', 'nmcli dev wifi connect Å'],
]
N=len(binds)

mkeys="org.gnome.settings-daemon.plugins.media-keys"
_locstr="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom"
_ck=f"{mkeys}.custom-keybinding:{_locstr}" 

# Create spaces for $N keybindings, emulating the command:
# gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"
locations=""
for i in range(0,N-1):
    locations+=f"'{_locstr}{i}/', "
locations+=f"'{_locstr}{N-1}/' "
#print(f"gsettings set {mkeys} custom-keybindings \"[ {locations} ]\"")
os.system(f"gsettings set {mkeys} custom-keybindings \"[ {locations} ]\"")

for i,bind in enumerate(binds):
    ck = f"{_ck}{i}/"
    print(f"gsettings set {ck} name           \"{bind[0]}\" ")
    os.system(f"gsettings set {ck} name       \"{bind[0]}\" ")
    os.system(f"gsettings set {ck} binding  \"{bind[1]}\" ")
    os.system(f"gsettings set {ck} command  \"{bind[2]}\" ")

# test with:
i=14
ck=f"{_ck}{i}/"
# in a shell, test with: 
# gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings
print(f"{ck}")
print(os.system(f"gsettings list-recursively {ck}"))
