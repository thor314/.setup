#!/bin/zsh
echo configuring checkin script

checkin(){
  read "check?continue? y/n: "
  if [[ "$check" != "y" ]]; then
    echo bye
    exit 0
  else
    echo continuing...
  fi
}

