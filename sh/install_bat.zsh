#/bin/zsh

dir=$(pwd)
cargo install --locked bat # better than cat and less
cd $HOME/.files/setup/clones
git clone https://github.com/eth-p/bat-extras # bat(diff|grep|man|pipe|watch)

cd bat-extras 
sudo apt install gawk # dependency
./build.sh
# maybe necessary if installed via sudo:
# git config --global --add safe.directory /home/thor/.files/setup/clone/bat-extras
cd $dir

