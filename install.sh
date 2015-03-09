#!/bin/bash

set -e

do_install() {
# update apt
sudo apt-get -y update
# sudo apt-get -y upgrade

mkdir -p $HOME/bin
mkdir -p $HOME/workspace
mkdir -p $HOME/share
mkdir -p $HOME/tmp
mkdir -p $HOME/usr
mkdir -p $HOME/var
mkdir -p $HOME/downloads

mkdir -p $HOME/usr/local
mkdir -p $HOME/var/log

# install basic packages
sudo apt-get -y install wget vim zsh git

[ `basename $SHELL` != "zsh" ] && chsh -s `which zsh` && echo "please reboot or re-login"

git clone https://github.com/sxend/dotfiles.git $HOME/share/dotfiles

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

cd $HOME/tmp

wget http://mirror.sdunix.com/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.zip
unzip apache-maven-3.2.5-bin.zip
mv apache-maven-3.2.5 $HOME/usr/local/maven
rm apache-maven-3.2.5-bin.zip
echo 'add PATH $HOME/usr/local/maven'

wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.7/sbt-0.13.7.tgz
tar xzf sbt-0.13.7.tgz
mv sbt $HOME/usr/local/sbt
rm sbt-0.13.7.tgz
echo 'add PATH $HOME/usr/local/sbt'

wget https://services.gradle.org/distributions/gradle-2.3-bin.zip
unzip gradle-2.3-bin.zip
mv gradle-2.3 $HOME/usr/local/gradle
rm gradle-2.3-bin.zip
echo 'add PATH $HOME/usr/local/gradle'

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

ln -s $HOME/share/dotfiles/dot.zshrc $HOME/.zshrc
}

do_install