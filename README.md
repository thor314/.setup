# Setting up a new machine:
Before installing on a new machine, need to sync an ssh key with github. Paste the following:
```sh
# set caps lock to ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"
# revert: gsettings reset org.gnome.desktop.input-sources xkb-options
# or mannualy: Open Gnome Tweaks to map Capslock to Ctrl
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>h']"

echo -e "\n\nGenerate an ssh key:"
ssh-keygen -t ed25519 -C thorck@pm.me
ssh-add

# will open a browser and authenticate with github
sudo apt install -y gh
sudo apt install -y hub
gh auth login

git clone git@github.com:thor314/.setup.git

git config --global user.name "Thor Kampefner"
```

then: `git config --global user.email "$EMAIL"`

Then work through the parts. Not fun, but makes the most reproducible and easiest to debug builds. 

Todo: 
- test the refactored keybind script
- maybe: do the gui installs first, so I can log into everything while installing all my binaries

2023-11-03 debug note: tried to refactor with MEDIA_KEYS and BIND_DIR, as well as multi-line strings. May cause
issues, will have to test next install.

## Pending recurring issue
If issues with system keyboard persist:
```
sudo localectl set-x11-keymap dvorak
```
