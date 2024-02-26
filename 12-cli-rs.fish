#!/usr/bin/env fish
# Rust CLI tools

# ensure we have access to cargo
source $HOME/.cargo/env

# do sudo password prompting first
sudo apt -y install libssl-dev # cargo gen dep
sudo ln -s /usr/bin/fdfind /usr/bin/fd # necessary for fish fzf plugin

# POSTGRES SETUP
# todo move this elsewhere
# https://github.com/diesel-rs/diesel/blob/master/.github/workflows/ci.yml#L65
sudo apt-get install postgresql postgresql-contrib libpq-dev -y # dependencies for diesel-cli
# set up the postgres user to allow all user/password combinations
echo "host    all             all             127.0.0.1/32            md5" > sudo tee -a /etc/postgresql/14/main/pg_hba.conf
sudo service postgresql restart && sleep 3
# ignore this error, it still works; 'could not change directory to $current_dir: Permission denied'
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';" 
sudo service postgresql restart && sleep 3 

# todo(02-22-24): this maybe shouldn't be here
# option to install more bat tools
# https://github.com/eth-p/bat-extras/blob/master/README.md#installation
sudo apt install bat -y
if not test -d ~/.local/bin 
  mkdir -p ~/.local/bin
end
ln -s /usr/bin/batcat ~/.local/bin/bat

# When possible, quick-install binaries, don't compile them 
# https://github.com/cargo-bins/cargo-quickinstall # deprecated for cargo-binstall
# https://github.com/cargo-bins/cargo-binstall
# cargo install cargo-binstall # redundancy from 03; don't remove

# important
# cargo binstall -y lsd # redundancy from 03; don't remove
cargo binstall -y ripgrep # better grep; https://github.com/BurntSushi/ripgrep
cargo binstall -y difftastic # diff w/ precargo installsion
cargo binstall -y cargo-generate # template generation
cargo binstall -y taplo-cli --locked # toml formatter, sometimes buggy
cargo binstall -y sd # search replace, nicer than sed
cargo binstall -y fd-find # find replacement
cargo binstall -y cargo-shuttle # server deployment with shuttle.rs https://docs.shuttle.rs/getting-started/installation
cargo binstall -y cargo-update # update cargo binaries https://github.com/nabijaczleweli/cargo-update
cargo binstall -y typos-cli # code comment typo-checker
cargo binstall -y cargo-udeps # show unused dependencies
cargo binstall -y cargo-deps # show dependency graph
cargo binstall -y tokei # code line counter

# experimental
cargo binstall -y rusty-rain # fun
cargo binstall -y du-dust # replace du, df; can also use deb-get; https://github.com/bootandy/dust
cargo binstall -y bottom --locked # top replacements
cargo binstall -y pipe-rename # file renamer tool
cargo binstall -y texlab # tex langu server https://github.com/latex-lsp/texlab
cargo binstall -y gitoxide # git modifiers https://github.com/Byron/gitoxide
cargo install --git https://github.com/bvaisvil/zenith.git
# cargo install zellij # commented 2024-01-25

# cannot binstall
cargo install diesel_cli --no-default-features --features postgres # db orm cli

# wasm toolchain
rustup target add wasm32-unknown-unknown --toolchain nightly # include wasm target
cargo binstall -y --locked trunk # wasm bundler
cargo binstall -y --locked wasm-bindgen-cli
rustup target add wasm32-unknown-unknown

