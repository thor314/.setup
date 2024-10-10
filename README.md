# Setting up a new machine:
*self-soothing security blanket slash reminder to self about script vs syncing from snapshot*

This setup script is slow and Not Fun, but does reduce reproducibility issues down the line.

Before installing on a new machine, we need to sync an ssh key with github. 

See changelog.md for short history.

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

# misc convenient, do now to save some some frustration:
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>h']"
```

### afterwards: setup by hand 
still to do: 
- settings
    - desktop - background set manually, hide minimize button
    - notifications - ignore this for now, but we will have to turn these off
    - power - adjust power saving options
    - mouse speed up
    - keyboard - keybindings - some keybindings have conflicts and need to be manually updated
    - users - profile pic update
    - about - update hostname if haven't already
    - os upgrade - update recovery partition (takes awhile; do last)
- sign into firefox
    - firefox settings search - turn off suggestions and shortcuts
    - privacy - turn off autofill; turn on save passwords just to turn off suggest; then turn back off
    - set up 1password
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
    - dark reader hotkeys alt-j, alt-k
    - manage tab hotkeys update
    - pin ublock, dark reader, vimium, 1password; unpin pocket
- pop shop (Ctrl-I) - update all
- Extensions - disable cosmic dock, desktop icons ng, and (desktop only) x11 gestures
- Tweaks - only used to set capslock to ctrl, which I should have already done
- sign into obsidian and sync vault
- log into 2FA websites and apps in a batch so I don't have to phone-fiddle later
    - paypal, amazon, github, protonmail, twitter, google, coingecko, facebook, etsy, substack, openai, claude
    - discord, slack, spotify, signal, telegram

### Pending recurring issue
If issues with system keyboard not-dvorak persist:
```
# localectl list-x11-keymap-variants # see list of keymap options
sudo localectl set-x11-keymap dvorak
sudo update-initramfs -u # update initial ramdisk to apply changes at boot time
```
