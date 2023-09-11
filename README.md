# Setting up a new machine:
Aiming for maximal simplicity here. Can install all at once with `install.sh`, or one at a time. 

Before installing on a new machine, need to sync an ssh key with github. Paste the following:
```sh
echo -e "\n\nGenerate an ssh key:"
ssh-keygen -t ed25519 -C thorck@pm.me
ssh-add

# will open a browser and authenticate with github
sudo apt install -y gh
sudo apt install -y hub
gh auth login

git clone git@github.com:thor314/.setup.git
```

 
