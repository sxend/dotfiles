#!/bin/bash

sudo apt-get -y install curl vim sublime-text zsh

git config --global alias.co checkout
git config --global alias.st 'status'
git config --global alias.br 'branch'

curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash
source ~/.nvm/nvm.sh
nvm install iojs
