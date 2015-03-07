#!/bin/bash

# update apt
sudo apt-get -y update
sudo apt-get -y upgrade

mkdir -p $HOME/.bin
mkdir -p $HOME/downloads

# install basic packages
sudo apt-get -y install wget curl vim zsh git
ZSH_INSTALLED=$(cat /etc/passwd| grep `whoami` | grep zsh | wc -l)
if [ ${ZSH_INSTALLED} -eq 0 ]
	then
	chsh -s `which zsh`
fi

# git alias
git config --global alias.co checkout
git config --global alias.st 'status'
git config --global alias.br 'branch'

# install nvm
curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash

sudo apt-get -y install docker.io apparmor

wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.7/sbt-0.13.7.tgz
tar xzf sbt-0.13.7.tgz
mv sbt $HOME/.bin/sbt
rm sbt-0.13.7.tgz

cp .zshrc $HOME/.zshrc
