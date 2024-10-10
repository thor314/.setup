#!/bin/fish
# has to be in fish, to be compatible with nvm plugin

# a fast npm https://pnpm.io/installation
npm i -g pnpm
# curl -fsSL https://get.pnpm.io/install.sh | sh - # uncomment if above bugs
pnpm i -g vite

pnpm i -g create-react-app

pnpm i -g bash-language-server # https://github.com/bash-lsp/bash-language-server
# https://github.com/mermaid-js/mermaid-cli
pnpm i -g @mermaid-js/mermaid-cli && ./node_modules/.bin/mmdc -h

## Install misc less-used but maybe useful language servers 
# https://github.com/helix-editor/helix/wiki/How-to-install-the-default-language-servers
pnpm i -g yaml-language-server # https://www.npmjs.com/package/yaml-language-server
pnpm i -g vscode-html-languageservice # https://github.com/microsoft/vscode-html-languageservice
pnpm i -g typescript-language-server typescript # https://github.com/typescript-language-server/typescript-language-server
pnpm i -g dockerfile-language-server-nodejs # https://github.com/rcjsuen/dockerfile-language-server-nodejs
pnpm i -g vscode-langservers-extracted # vscode's HTML/JSON/CSS:  https://github.com/hrsh7th/vscode-langservers-extracted

# bun https://bun.sh/
curl -fsSL https://bun.sh/install | bash
npm install -g typescript-language-server typescript

# deprecated
# lean prover
# https://leanprover-community.github.io/install/debian.html
# wget -q https://raw.githubusercontent.com/leanprover-community/mathlib-tools/master/scripts/install_debian.sh && bash install_debian.sh ; source ~/.profile
# rm install_debian.sh
# pnpm i -g lean-language-server

# Issues:  solc not detected by helix, may be upstream issues *shrug*, not my monkeys
# npm i -g solc # https://docs.soliditylang.org/en/latest/installing-solidity.html

# pnpm i -D -g node-sass @types/node-sass # deprecated
