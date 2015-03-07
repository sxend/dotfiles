#!/bin/bash

# update apt
sudo apt-get -y update
sudo apt-get -y upgrade

mkdir -p $HOME/.tools
TOOLS_DIR=$HOME/.tools

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

wget http://mirror.sdunix.com/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.zip
unzip apache-maven-3.2.5-bin.zip
mv apache-maven-3.2.5 $TOOLS_DIR/maven
rm apache-maven-3.2.5-bin.zip

wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.7/sbt-0.13.7.tgz
tar xzf sbt-0.13.7.tgz
mv sbt $TOOLS_DIR/sbt
rm sbt-0.13.7.tgz

wget https://services.gradle.org/distributions/gradle-2.3-bin.zip
unzip gradle-2.3-bin.zip
mv gradle-2.3 $TOOLS_DIR/gradle
rm gradle-2.3-bin.zip

# Ricty install
mkdir -p $HOME/.fonts/migu-1m
sudo apt-get install -y fontforge fonts-inconsolata
wget http://jaist.dl.sourceforge.jp/mix-mplus-ipa/59022/migu-1m-20130617.zip
unzip migu-1m-20130617.zip
mv migu-1m-20130617/*.ttf $HOME/.fonts/migu-1m
fc-cache -vf
rm -rf migu-1m-20130617.zip
rm -rf migu-1m-20130617

mkdir -p $HOME/.fonts/Ricty
git clone -b 3.2.4 git@github.com:yascentur/Ricty.git
cd Ricty && ./ricty_generator.sh auto
cp -f Ricty*.ttf $HOME/.fonts/Ricty
cd ..
fc-cache -vf
rm -rf Ricty/

cp .zshrc $HOME/.zshrc
