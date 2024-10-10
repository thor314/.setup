# Setting up a new machine:
Before installing on a new machine, need to sync an ssh key with github. Paste the following:

```sh
# 1. We need to create an ssh key, so that Github lets us clone this repo.
echo -e "\n\nGenerate an ssh key:"
# may have to set hostname manually!
ssh-keygen -t ed25519 -C thor-<HOSTNAME> # set hostname up later, change this manually 
ssh-add

# 2. Install github communication and keychain CLIs. Tell github about the ssh key.

# note that apt install gh is very out of date, and we'll install the updated version later but this works fine now
sudo apt install gh

echo "will open a browser and authenticate with Github."
# will tell github about our new ssh key, though the key will have a dumb name (GitHub CLI)
gh auth login
# goto github.com/settings/keys and delete that key, add it with the correct name
gh ssh-key add .ssh/id_ed25519.pub
echo "confirm our new key is listed."
gh ssh-key list

# 3. Install stuff.
git clone git@github.com:thor314/.setup.git
```

Then work through the parts. 

### Comforting security blanket slash reminder to self about script vs syncing from snapshot
This setup script is slow and Not Fun, but does reduce reproducibility issues down the line.

## Settings to include early that make life good
Figure out where to include these in the install script:

```
## these settings have not been tested
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>h']"
git config --global user.name "Thor Kampefner"
git config --global user.email "$EMAIL"
```

### Pending recurring issue
If issues with system keyboard not-dvorak persist:
```
# localectl list-x11-keymap-variants # see list of keymap options
sudo localectl set-x11-keymap dvorak
sudo update-initramfs -u # update initial ramdisk to apply changes at boot time
```

## changelog
- 2024-10-09 - major refactor overhaul
- 2024-01-26 - I should have a changelog
- 2023-12-24 refactored keybind set script. Test the refactored keybind script more on next install. 
    - known issue: will not unbind system keybinds, have to do that manually.
