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

# misc convenient:
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>h']"
```

Then work through the parts. 

### Comforting security blanket slash reminder to self about script vs syncing from snapshot
This setup script is slow and Not Fun, but does reduce reproducibility issues down the line.

### Pending recurring issue
If issues with system keyboard not-dvorak persist:
```
# localectl list-x11-keymap-variants # see list of keymap options
sudo localectl set-x11-keymap dvorak
sudo update-initramfs -u # update initial ramdisk to apply changes at boot time
```

### after this script
still to do: 
- settings
    - desktop - background set manually, hide minimize button
    - notifications - ignore this for now, but we will have to turn these off
    - power - adjust power saving options
    - mouse speed up and natural scrolling on
    - keyboard - keybindings - some keybindings have conflicts and need to be manually updated
    - users - profile pic update
    - about - update hostname if haven't already
    - os upgrade - update recovery partition (takes awhile; do last)
- sign into firefox, set up 1password
    - firefox settings search - turn off suggestions and shortcuts
    - privacy - turn off autofill
    - setup hotkey tabs
        - m https://mail.proton.me/u/2/inbox
        - c https://calendar.google.com/calendar/u/0/r
        - t https://assistant.google.com/tasks
        - o https://chat.openai.com/
        - g https://github.com/thor314
        - w https://tweetdeck.twitter.com
        - x https://x.com/messages
        - p https://docs.google.com/spreadsheets/d/17u74o6Z5y6o8YGpMzJ4YLM3dF01WkwoUYblAS8wHqoM
        - f https://www.facebook.com/messages/t
        - r https://feedly.com/
- sign into obsidian and sync vault


## changelog
- 2024-10-09 - major refactor overhaul
- 2024-01-26 - I should have a changelog
- 2023-12-24 refactored keybind set script. Test the refactored keybind script more on next install. 
    - known issue: will not unbind system keybinds, have to do that manually.
