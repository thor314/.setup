# !/bin/sh
# Obtain this script:
# git clone https://github.com/thor314/.setup.git && cd .setup
# Use this script:
# source install.sh
# then call functions one by one, fixing any bugs as they arise

alias agi='sudo apt install -y'
alias ci='cargo install'
alias sni='sudo snap install -y'
alias pipi='pip3 install'
SH=$HOME/.setup/sh
mkdir $SH/../clones
mkdir $SH/../debs

getzsh(){
  echo "shell is $SHELL"
  if [[ "$SHELL" != "/bin/zsh" ]]; then
    echo install zsh
    agi zsh
    echo making zsh the default shell for thor...
    chsh -s /usr/bin/zsh thor
    export SHELL="zsh"
    zsh
  else
    echo zsh already in use
  fi

  echo setting up oh-my-zsh...
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

getvim(){
  agi vim-gui-common # fully featured vim
  agi vim-runtime # fully featured vim
}

getcredentials(){
  echo generate an ssh key
  ssh-keygen -t ed25519 -C thorck@pm.me
  ssh-add 
  echo "\ntell github about your new ssh key:\n"
  cat $HOME/.ssh/id_ed25519.pub
  read "tmp?Press enter to continue"

  # https://github.com/microsoft/Git-Credential-Manager-Core#linux-install-instructions
  echo "This will run in the background, reducing 2FA weight when talking to github."
  pushd $HOME/.setup/debs
  agi ./gcm* # may need to replace w dpkg -i
  wget https://github.com/GitCredentialManager/git-credential-manager/releases/download/v2.0.696/gcmcore-linux_amd64.2.0.696.deb

  git-credential-manager-core configure && popd

  echo "generate a gpg key. Choose 4096 when prompted."
  gpg --full-generate-key
  gpg --list-secret-keys --keyid-format LONG
  read  "pubkey?Enter your key id: "
  gpg --armor --export $pubkey
  read  "tmp?tell github about your new gpg key:\n\n press enter to continue"
  echo "done. For github ssh and gpg help: https://docs.github.com/en/github-ae@latest/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent"
}

getgh_hub(){
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt update -y
  agi gh
  agi hub
  gh auth login
}

getpms(){
  # snap flatpak python rust go nodejs
  sudo apt install snapd
  sudo apt install flatpak
  agi python3-dev python3-pip python3-setuptools

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source $HOME/.cargo/env
  rustup update && rustup toolchain install nightly && rustup default nightly
  rustup target add wasm32-unknown-unknown --toolchain nightly # include wasm target

  wget https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz
  mv go1.18.2.linux-amd64.tar.gz $HOME/.setup/clones
  export PATH=$PATH:/usr/local/go/bin && go version && echo Go installed

  mkdir $HOME/.config/nvm
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
   nvm install node && echo nodejs installed
}

dotfiles(){
  hub clone -recursive .files $HOME/.files && pushd $HOME/.files
  pipi dotbot && sudo pipi dotbot
  echo setting up dotfiles...
  dotbot -c install.conf.yaml && popd
  # now that we have a zsh.d directory, set up prompt
  # https://github.com/romkatv/powerlevel10k. Fonts should be vc'd by dotbot and set up by alacritty.
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.zsh.d/oh-my-zsh/custom/themes/powerlevel10k
}

apttools(){
  agi clang curl libssl-dev llvm pkg-config shfmt # common general deps
  # CLI tools
  agi hugo # static site generator blog management
  agi gist
  agi duf
  agi pass # password manager CLI
  agi xclip # clipboard
  agi maim # screenshot, better than scrot, sometimes better than gnome-screenshot
  agi xdotool # simulate pressing buttons, very useful script utility
  agi hub # mostly deprecated for gh
  agi texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
  agi pandoc # export text files to other text files
  agi graphviz # graphing tools, including dot
  agi git-filter-repo # holy shit a useful git tool for selectively filtering git history 
  # GUIs
  agi gnome-tweaks # tweak destkop settings gui
  agi evince # pdf viewer
  agi telegram-desktop # messaging
  agi discord
  agi vlc # simple playback
  agi firefox
}

pytools(){
  # CLI tools
  pipi pytest # testing suite
  pipi flake8 # linter, expands pep8 standard around pyflakes package
  pipi autopep8 # formatter
  pipi pz # Python as a command line tool
  pipi thefuck --user # accident replacement
  pipi tldr # a fire replacement for man
  pipi python-lsp-server
  # Libraries
  pipi GitPython # manage git from python
  # pipi black # alt formatter linter, stricter than autopep8
  # pipi pywal  # theme setting silliness, not too useful
}

cargotools(){
  # CLI tools
  ci ripgrep # better grep
  ci zellij
  ci du-dust # replace du, df
  ci bottom --locked # top replacements
  ci --git https://github.com/bvaisvil/zenith.git
  ci difftastic # diff w/ precision
  ci pipe-rename # file renamer tool
  ci cargo-generate
  ci rusty-rain
  ci taplo-cli --locked # toml formatter
  ci lsd
  ci sd # search replace, nicer than sed
  ci fd-find # find replacement

  echo go here: https://github.com/artempyanykh/marksman/releases, install markdown language server
  pushd $HOME/.setup/clones && git clone https://github.com/helix-editor/helix && cd helix
  cargo install --path helix-term && popd
  pushd $HOME/.setup/clones && wget https://github.com/artempyanykh/marksman/releases/download/2022-10-30/marksman-linux
  mv marksman* marksman && chmod +x marksman && mv marksman $HOME/.local/bin
  # may be deprecated soon when RA bin gets included in cargo
  # pushd clones && curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
  # chmod +x ~/.local/bin/rust-analyzer && popd
  ./$SH/bat.sh
  # GUI tools
  ./$SH/alacritty.sh
}

othertools(){
  # linter for dotenv files https://github.com/dotenv-linter/dotenv-linter
  curl -sSfL https://git.io/JLbXn | sh -s -- -b "$HOME/.share/bin" v2.0.0
  # https://github.com/bash-lsp/bash-language-server
  npm i -g bash-language-server
  agi shellcheck # https://www.shellcheck.net/
  # CLI
  pushd $HOME/.setup/clones && hub clone https://github.com/noctuid/tdrop && cd tdrop && sudo make install && popd
  # GUI
  sni chromium # secondary browser
  # https://signal.org/en/download/linux/
  wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
  cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
   echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
  sudo apt update && agi signal-desktop
  sni spotify # spotify
  # i'm learning: use flatpak > snap for less-sandboxed applications. eg: git backups, and open links in correct browser
  flatpak install -y flathub md.obsidian.Obsidian
  flatpak install -y flathub us.zoom.Zoom # zoom not well maintained across package managers, weird
  flatpak install -y flathub org.zotero.Zotero # zotero snap not as well maintained
  flatpak install -y flathub com.obsproject.Studio
  flatpak install -y flathub org.mozilla.Thunderbird
  flatpak install -y flathub ch.protonmail.protonmail-bridge 
  flatpak install -y flathub com.visualstudio.code 
  # flatpak is unofficial, and has general (also copilot) issues. Snap will not open browser links in correctly.
  pushd $HOME/.files/clones && wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 && sudo dpkg -i ./code_*_amd64.deb 
  popd
  # buggy text replacement, to be removed
  sudo snap install espanso --classic --channel=latest/edge
  snap run espanso service register
  snap run espanso start
  # https://github.com/mermaid-js/mermaid-cli
  npm install @mermaid-js/mermaid-cli && ./node_modules/.bin/mmdc -h

  go install github.com/yoheimuta/protolint/cmd/protolint@latest
  # Emoji option 1
  ./$HOME/.files/setup/sh/rofi.sh
  # Emoji option 2 (good)
  sni emote # emoji picker on ctrl-alt-e

  curl -LO https://github.com/BetaPictoris/dict/releases/latest/download/dict
  sudo install -Dt /usr/local/bin -m 755 dict
  rm dict

  # https://github.com/micahflee/torbrowser-launcher
  flatpak install -y flathub com.github.micahflee.torbrowser-launcher 

}

fonts(){
  agi fonts-firacode # ligature enabled programming font
  agi fonts-karla # https://fonts.google.com/specimen/Karla
  # already installed in my fonts backup:
  # https://fonts.google.com/specimen/Karla
  # https://brailleinstitute.org/freefont
  # https://fonts.google.com/specimen/Lora#standard-styles
}

homesetup(){
  echo "setting up home directory..."
  pushd $HOME
  rm -r Documents Desktop Music Pictures Public Templates Videos
  hub clone blog --recursive
  hub clone cryptography
  hub clone backgrounds img/backgrounds
  hub clone profile img/profile
  hub clone keep
  hub clone note
  hub clone uncloak
  hub clone pazk zk
  hub clone cron 
  hub clone .private && cd .private && dotbot -c install.conf.yaml
  popd

  agi openssh-server
  sudo systemctl start ssh
  sudo systemctl enable ssh
  echo "\n\nmy ip address is $(hostname -I | cut --delimiter=' ' -f1)"
  echo "get shared key from another machine. From my other trusted machine, enter:"
  echo "gpg --export-secret-keys thor-shared | ssh thor@IPADDRESS gpg --import"
  echo "if that worked, I should be able to open my secrets file. Add my ip to env vars".
  read "tmp?press enter to continue"
  vi $HOME/.private/secrets.gpg
}

wmutils(){
  ## utils specifically for window manager shenaniganery
  # agi rofi # window switcher, app launcher, dmenu replacement; should be already set up in emoji
  agi dmenu # more primitive launcher than rofi
  agi feh # set background image
  agi conky # lightweight system monitor, display info
  agi dunst # desktop notifications
  agi xmobar lemonbar polybar # bars to play with
  ./$SH/leftwm.sh
  ./$SH/picom.sh
}

setupcrons(){
  # set up cronscripts in /var/spool
  echo "calling crontab -e, copy and manually paste the following into it"
  cat $HOME/.setup/crontab
  read "tmp?Copy and press enter to continue"
  crontab -e
  echo "did you forget to include a newline at the end of the crontab?"

}

# UNDONE (probably less hassle to do this by hand)
echo "manually poke settings"
echo "increase mouse speed, set natural scrolling"
echo "desktop suspend timeout"
echo hostname
echo tweaks emacs input
echo tweaks startup applications
echo background
echo login to applications firefox, signal, discord, telegram, obsidian
echo "keybinds; most annoying to do with GNOME, yike"
# sudo hostnamectl set-hostname $name

# graveyard
# sni notion-snap # secondary notes... NOTION'S DESKTOP CLIENT IS CRAP
# move this below
#  cargo install cargo-tarpaulin # code coverage
# install RA in VScode instead
# git clone https://github.com/rust-analyzer/rust-analyzer.git
# pushd rust-analyzer
# cargo xtask install --server
# popd


