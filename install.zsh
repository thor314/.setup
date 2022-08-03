#!/bin/zsh
 
SH="$HOME/.files/setup/sh"
source $SH/setup_checkin.zsh
source $SH/setup_aliases.zsh 

deps(){
  echo "installing dependencies..."
  agi clang curl libssl-dev llvm libudev-dev pkg-config shfmt
  agi cmake fontconfig # dependencies for alacritty
  sni shfmt # bat dep
  agi python3-dev python3-pip python3-setuptools # fuck deps
  agi libgmp3-dev # substrate
}
deps
cli_tools1(){
  agi hugo # static site generator blog management
  pipi thefuck --user # accident replacement
  ci ripgrep # better grep
  agi gist 
  agi hub
  $SH/install_gh.zsh
  agi pass # password manager CLI
  agi xclip # clipboard
  agi maim # screenshot, better than scrot, sometimes better than gnome-screenshot
  pipi pz # Python as a command line tool
  $SH/install_bat.zsh
  ci zellij
}
cli_tools3(){
  ci du-dust # replace du, df
  agi duf
  ci bottom --locked # top replacements
  ci --git https://github.com/bvaisvil/zenith.git 
  ci difftastic # diff w/ precision
  ci pipe-rename # file renamer tool
  pipi tldr # a fire replacement for man
  agi xdotool # simulate pressing buttons, very useful script utility
  $SH/install_espanso.zsh
}
cli_tools1
cli_tools2
cli_tools3
#checkin

fonts(){
  echo "getting fonts..."
  agi fonts-firacode # ligature enabled programming font
  # wget https://github.com/larsenwork/monoid/blob/master/Monoisome/Monoisome-Regular.ttf\?raw\=true
}
fonts 

home_setup(){
  echo "setting up home directory..."
  pushd $HOME
  rm -r Documents Desktop Music Pictures Public Templates Videos
  hub clone blog --recursive
  hub clone cryptography 
  hub clone entropyxyz/entropy-core entropy/core
  hub clone entropyxyz/tofn entropy/tofn
  hub clone backgrounds img/backgrounds
  hub clone profile img/profile
  hub clone keep
  hub clone note
  hub clone web
  hub clone pazk zk
  popd
}
home_setup

# python packages
pypackages(){
  pipi GitPython # manage git from python
  pipi pytest # testing suite
  pipi flake8 # linter, expands pep8 standard around pyflakes package
  pipi autopep8 # formatter
  # pipi black # alt formatter linter, stricter than autopep8
  # pipi pywal  # theme setting silliness, not too useful
}
pypackages

js_packages(){
  # https://github.com/mermaid-js/mermaid-cli
  npm install @mermaid-js/mermaid-cli && ./node_modules/.bin/mmdc -h
}
js_packages 

# GUI applications
guis(){
  agi gnome-tweaks # tweak destkop settings gui
  agi evince # pdf viewer
  #sni firefox
  sni chromium # secondary browser
  sni signal-desktop # messaging
  agi telegram-desktop # messaging
  sni spotify # spotify
  agi discord 
  sudo sni code --classic
  flatpak install md.obsidian.Obsidian # flat > snap, so that git extension works
  $SH/configure_alacritty.zsh
  cd debs
  wget https://zoom.us/client/latest/zoom_amd64.deb && dpkg -i zoom_amd64.deb
  wget https://protonvpn.com/download/protonvpn-stable-release_1.0.1-1_all.deb
  agi gnome-shell-extension-appindicator gir1.2-appindicator3-0.1 #deps
  sudo dpkg -i protonvpn-stable-release_1.0.1-1_all.deb
  agi protonvpn-cli
  cd ../clones
  git clone https://github.com/noctuid/tdrop 
  cd tdrop
  sudo make install 
  cd ../..
}
guis

emojis(){
  # Emoji option 1 (use rofi)
  $SH/install_rofi_emoji.zsh
  # Emoji option 2
  sni emote # emoji picker on ctrl-alt-e
  # Emoji option 3 - see espanso inline replacement options
}
emojis 

go_packages(){
  go install github.com/yoheimuta/protolint/cmd/protolint@latest
}
go_packages 

latex(){
  agi texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
}
latex 

experiments(){
  ## if I eventually like window-managers like i3 or leftwm again, use these
  agi rofi # window switcher, app launcher, dmenu replacement
  # agi feh # set background image
  # agi conky # lightweight system monitor, display info
  # agi dunst # desktop notifications
}
experiments

#set up some directories, not very clean
python sh/configure_keybinds.py
cd ..
dotbot -c install.conf.yaml
cd $HOME
cd

# UNDONE (probably less hassle to do this by hand)
echo "still to do..."
echo "increase mouse speed, set natural scrolling"
echo gsettings mouse
echo gsettings workspaces fixed to three
echo "desktop suspend timeout"
echo gsettings hostname
echo tweaks emacs input
echo tweaks startup applications
echo tweak background
echo login to firefox, signal, discord, telegram, obsidian
echo basic keybinds # most annoying to do


# graveyard 
# sni notion-snap # secondary notes... NOTION'S DESKTOP CLIENT IS CRAP

