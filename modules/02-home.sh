#!/bin/bash

echo -e "setting up home directory...\n"
pushd $HOME
rm -r Documents Desktop Music Pictures Public Templates Videos

repos=(".private" ".files" ".keep" ".cron" "projects")
for repo in "${repos[@]}"; do
	gh repo clone $repo
done

gh repo clone helix $HOME/.config/helix

pip install dotbot
PATH="$PATH:$HOME/.local/bin"
cd $HOME/.files && dotbot -c install.conf.yaml && cd
cd $HOME/.private && dotbot -c install.conf.yaml && cd

mkdir r
mkdir fun

popd
