#!/bin/bash
# Install zsh if not the current $SHELL
get_zsh(){
  echo "shell is $SHELL"
  if [[ "$SHELL" != "/bin/zsh" ]]; then
    echo install zsh
    sudo apt install zsh
    echo make zsh the default shell for thor
    chsh -s /usr/bin/zsh thor
    export SHELL="zsh"
    echo setting up oh-my-zsh...
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    zsh
  else
    echo zsh already in use
  fi
}

get_zsh
