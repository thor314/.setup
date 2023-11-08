# recent commands (as of 2023-03-21)
flatpak install -y flathub com.slack.Slack
flatpak install flathub com.valvesoftware.Steam

# Penumbra cli
# https://guide.penumbra.zone/main/pcli/install.html#linux
break
sudo apt install build-essential pkg-config libssl-dev clang git-lfs -y
git clone https://github.com/penumbra-zone/penumbra clones
#cd clones/penumbra && git fetch && git checkout v0.63.1
#cargo build --release --bin pcli
