#!/bin/bash

# silences warnings
PATH=$PATH:$HOME/.local/bin

# language tooling
pip install jupyter --upgrade
pip install flake8 # linter, expands pep8 standard around pyflakes package
pip install autopep8 # formatter
pip install python-lsp-server

# cli
pip install tldr # a fire replacement for man
# may deprecate:
pip install pz # use python as a slow command line text transform tool

# libs 
pip install pytest # testing suite
pip install GitPython # manage git from python

# pip install black # alt formatter linter, stricter than autopep8
# pip install pywal  # theme setting silliness, not too useful

