#!/bin/bash

# update apt
sudo apt-get -y update
sudo apt-get -y upgrade

mkdir -p $HOME/.bin
mkdir -p $HOME/downloads

# install basic packages
sudo apt-get -y install wget curl vim zsh git
chsh -s `which zsh`
cp .zshrc $HOME/.zshrc

# !! reboot or re-login

# git alias
git config --global alias.co checkout
git config --global alias.st 'status'
git config --global alias.br 'branch'

# install nvm
curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash
echo 'source $HOME/.nvm/nvm.sh' >> ~/.zshrc

sudo apt-get -y install docker.io apparmor

wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.7/sbt-0.13.7.tgz
tar xzf sbt-0.13.7.tgz
mv sbt $HOME/.bin/sbt
echo 'add PATH => $HOME/.bin/sbt/bin'


