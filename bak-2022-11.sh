#!/bin/sh
# Where unsorted commands should go
# If I get around to another refactor, reference:
# https://github.com/rsnk96/Ubuntu-Setup-Scripts/blob/main/1-BasicSetUp.sh

# Note:  /etc/sources.list.d/microsoft seems borked, removing it

# docker: https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
agu && agi docker-ce docker-ce-cli containerd.io docker-compose-plugin
# sudo docker run hello-world # test setup
# more docs: https://docs.docker.com/desktop/linux/install/ubuntu/
# systemctl --user start docker-desktop # start session
# systemctl --user enable docker-desktop # enable start on login
docker compose version # running?
# Or:
sudo snap install docker circleci
sudo snap connect circleci:docker docker

cargo install --git https://github.com/foundry-rs/foundry foundry-cli anvil --bins --locked
# snap install zotero-snap # not actually useful
cargo install spotify-tui
cargo install cargo-generate
agi valgrind # dynamic analysis framewor
cargo install gitui
cargo install so # stack overflow tui
pip install rainbowstream

# download fat 2.5Gb Davinci package   
# https://www.blackmagicdesign.com/products/davinciresolve/
# specifically for zk-hack group: https://drive.google.com/drive/folders/1Lt5-ehCF20cfX5KMQZp8VmvIRQPSMulJ
# Edit graphics in Canva

# install rhai
cd clones
hub clone rhaiscript/rhai && cd rhai
ci --path . --bins --features bin-features
cd ..

# Helix editor
pushd clones
git clone https://github.com/helix-editor/helix
cd helix
cargo install --path helix-term
# do this or clone it separately
# mkdir $HOME/.config/helix
# ln -s $PWD/runtime ~/.config/helix/runtime
popd

# Download language servers for toml, rs, py, and bash #
# Rust analyzer (duplicate?)
pushd clones
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
popd

# lldb-vscode debugger (helix). See: https://github.com/helix-editor/helix/wiki/Debugger-Configurations
pushd clones
curl -L "https://github.com/vadimcn/vscode-lldb/releases/download/v1.7.0/codelldb-x86_64-linux.vsix" -o "codelldb-x86_64-linux.zip"
unzip "codelldb-x86_64-linux.zip" "extension/adapter/*" "extension/lldb/*"
mv extension/ codelldb_adapter
rm "codelldb-x86_64-linux.zip"
ln -s codelldb_adapter/adapter/codelldb "$HOME/.local/bin/codelldb"
ln -s codelldb_adapter/adapter/codelldb "$HOME/.local/bin/lldb-vscode"
popd

# terminal html rendering tools
pip install html2text
agi w3m # prints html to text
agi jq # tool for working w json
ci toml2json


# rust profilers 
cargo install --git https://github.com/rust-lang/measureme crox flamegraph summarize
# tools for interacting with linux: https://brendangregg.com/linuxperf.html, https://fasterthanli.me/articles/when-rustc-explodes
# alternative: https://github.com/koute/not-perf
agi linux-tools-common linux-tools-generic linux-cloud-tools-generic # includes perf
# https://github.com/jonhoo/inferno 
ci inferno

# misc
ci rustfilt # rust demangler
ci cargo-deps # graph dependencies
agi mold # linker

# linter for dotenv files https://github.com/dotenv-linter/dotenv-linter
curl -sSfL https://git.io/JLbXn | sh -s -- -b "$HOME/.share/bin" v2.0.0

# autogenerate changelog from git commit messages https://github.com/orhun/git-cliff
# cargo install git-cliff

