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
#cp target/release/pcli ~/.cargo/bin
## New:
# cargo run --quiet --release --bin pcli init soft-kms generate
## Import:
# cargo run --quiet --release --bin pcli init soft-kms import-phrase
# generate the address for a numbered account between 0 and 4 billion
# cargo run --quiet --release --bin pcli view address 0

sudo apt install webp # webp cli tools
sudo apt-get -y install surfraw surfraw-extra # common internet search tools cli

### Web cam manipulation
# note about webcamoid - can't install, remove eventually
# more hassle than worth, akvcam badly documented elsewhere and webcamoid poorly maintained
# # virtual camera for linux, required for linux-fake-background
# firefox --new-tab https://github.com/webcamoid/akvcam/releases
# echo "download latest cli. to install: chmod +x *cli*.run && ./*cli*.run" 

### Proton VPN
firefox --new-tab https://protonvpn.com/support/official-linux-vpn-debian/
echo "download the latest protonvpn cli and install with eddy"
sudo apt-get install proton-vpn-gnome-desktop

# ssh key manager
sudo apt -y install keychain

hub clone --recursive gm $HOME/gm
hub clone --recursive rust-playground
hub clone --recursive python-playground
hub clone --recursive web-playground

cargo install typos-cli # code typo-checker

sudo apt-get install postgresql postgresql-contrib libpq-dev -y # dependencies for diesel-cli
cargo install diesel_cli --no-default-features --features postgres
# set up the postgres user to allow all user/password combinations
echo "host    all             all             127.0.0.1/32            md5" > sudo tee -a /etc/postgresql/10/main/pg_hba.conf
