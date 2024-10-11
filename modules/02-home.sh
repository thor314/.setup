#!/bin/bash

echo -e "setting up home directory...\n"
pushd "$HOME" || exit

rm -r Documents Desktop Music Pictures Public Templates Videos

repos=(".private" ".files" ".keep" ".cron" "blog")
for repo in "${repos[@]}"; do
	gh repo clone "$repo"
done

gh repo clone helix "$HOME"/.config/helix

# archive note 2024-10: convert-j-to-ts hotkeys-for-tab-stuff hufflepuff pebble-stark rdrop zkhn
mkdir projects && cd projects || exit
project_repos=("github_name" "obsidian-setup" "resume" "runi" "stickers" "tk-blog-publish" "tk-cargo-generate" \
  "circuit-examples" "uncloak" "badges")
for repo in "${project_repos[@]}"; do
	gh repo clone "$repo" 
done
cd ..

mkdir pluto && cd pluto || exit
gh repo clone pluto/web-prover
gh repo clone pluto/aes-proof
cd ..

mkdir playground && cd playground || exit
mkdir puzzles rust cryptography web
gh repo clone euler-rs-py puzzle/euler-rs-py
cd ..

mkdir tmp

pip install dotbot
PATH="$PATH:$HOME/.local/bin"
cd .files && dotbot -c install.conf.yaml && cd || exit
cd .private && dotbot -c install.conf.yaml && cd || exit

popd || exit
