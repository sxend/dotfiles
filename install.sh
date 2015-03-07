#!/bin/bash

# update apt
sudo apt-get -y update
sudo apt-get -y upgrade

mkdir -p $HOME/.tools
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
git config --global user.name sxend
git config --global user.email arimitsu.k+github@gmail.com

sudo apt-get -y install tig

# install nvm
curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash

sudo apt-get -y install docker.io apparmor

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get -y update
sudo apt-get -y install oracle-java7-installer
sudo apt-get -y install oracle-java8-installer

wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.7/sbt-0.13.7.tgz
tar xzf sbt-0.13.7.tgz
mv sbt $HOME/.tools/sbt
rm sbt-0.13.7.tgz

cp .zshrc $HOME/.zshrc
