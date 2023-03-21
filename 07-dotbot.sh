#!/bin/bash

cd $HOME/.files && dotbot -c install.conf.yaml && cd
read -p "\ndid files install correctly?"
cd $HOME/.private && dotbot -c install.conf.yaml && cd
read -p "\ndid private install correctly?"
