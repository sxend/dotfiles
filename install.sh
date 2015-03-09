#!/bin/bash

set -e

do_install() {

# create home/dirs
mkdir -p $HOME/bin
mkdir -p $HOME/workspace
mkdir -p $HOME/share
mkdir -p $HOME/tmp
mkdir -p $HOME/usr
mkdir -p $HOME/var
mkdir -p $HOME/downloads

mkdir -p $HOME/usr/local
mkdir -p $HOME/var/log

# update apt
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get -y update
# sudo apt-get -y upgrade

# install basic packages
sudo apt-get -y install wget vim zsh git unzip

# change login shell
[ `basename $SHELL` != "zsh" ] && chsh -s `which zsh` && echo "please reboot or re-login"

# clone dotfiles
git clone https://github.com/sxend/dotfiles.git $HOME/share/dotfiles
ln -s $HOME/share/dotfiles/dot.zshrc $HOME/.zshrc
ln -s $HOME/share/dotfiles/dot.vimrc $HOME/.vimrc
ln -s $HOME/share/dotfiles/dot.gitconfig $HOME/.gitconfig

# tig (git client) install
sudo apt-get -y install tig

# install oracle jdk
sudo apt-get -y install oracle-java7-installer
sudo apt-get -y install oracle-java8-installer

# install nvm
curl --insecure https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash

# install docker
sudo apt-get -y install docker.io apparmor

cd $HOME/tmp

local MVN_DIR=$HOME/usr/local/maven
mkdir -p ${MVN_DIR}
wget http://mirror.sdunix.com/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.zip
unzip apache-maven-3.2.5-bin.zip
mv apache-maven-3.2.5 ${MVN_DIR}/maven-3.2.5
ln -s ${MVN_DIR}/maven-3.2.5/bin/mvn $HOME/bin/mvn
rm apache-maven-3.2.5-bin.zip

local SBT_DIR=$HOME/usr/local/sbt
mkdir -p ${SBT_DIR}
wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.7/sbt-0.13.7.tgz
tar xzf sbt-0.13.7.tgz
mv sbt ${SBT_DIR}/sbt-0.13.7
ln -s ${SBT_DIR}/sbt-0.13.7/bin/sbt $HOME/bin/sbt
rm sbt-0.13.7.tgz

local GRADLE_DIR=$HOME/usr/local/gradle
mkdir -p ${GRADLE_DIR}
wget https://services.gradle.org/distributions/gradle-2.3-bin.zip
unzip gradle-2.3-bin.zip
mv gradle-2.3 ${GRADLE_DIR}/gradle-2.3
ln -s ${GRADLE_DIR}/gradle-2.3/bin/gradle $HOME/bin/gradle
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
git clone -b 3.2.4 https://github.com/yascentur/Ricty.git
cd Ricty && ./ricty_generator.sh auto && cp -f Ricty*.ttf $HOME/.fonts/Ricty && cd $HOME/tmp
fc-cache -vf
rm -rf Ricty/

}

do_install