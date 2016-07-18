#!/bin/bash

set -eu

do_install() {

# create home/dirs
mkdir -p $HOME/bin
mkdir -p $HOME/workspace
mkdir -p $HOME/share
mkdir -p $HOME/tmp
mkdir -p $HOME/opt
mkdir -p $HOME/var
mkdir -p $HOME/downloads

mkdir -p $HOME/var/log

cd $HOME/tmp

# update apt
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get -y update
# sudo apt-get -y upgrade

# install basic packages
sudo apt-get -y install wget vim zsh git unzip build-essential

# change login shell
[ `basename $SHELL` != "zsh" ] && chsh -s `which zsh` && echo "please reboot or re-login"

# clone dotfiles
if [ -e $HOME/share/dotfiles ]; then
  cd $HOME/share/dotfiles && git pull origin master && cd $HOME/tmp
else
  git clone https://github.com/sxend/dotfiles.git $HOME/share/dotfiles
fi

mkdir -p $HOME/.vim/bundle
if [ -e $HOME/.vim/bundle/neobundle.vim ]; then
  cd $HOME/.vim/bundle/neobundle.vim && git pull origin master && cd $HOME/tmp
else
  git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
fi


ln -s -f $HOME/share/dotfiles/dot.zshrc $HOME/.zshrc
ln -s -f $HOME/share/dotfiles/dot.zshrc.include $HOME/.zshrc.include
ln -s -f $HOME/share/dotfiles/dot.vimrc $HOME/.vimrc
ln -s -f $HOME/share/dotfiles/dot.gitconfig $HOME/.gitconfig
mkdir -p $HOME/.vim
ln -s -f $HOME/share/dotfiles/dot.vim/filetype.vim $HOME/.vim/filetype.vim

# tig (git client) install
sudo apt-get -y install tig

# install oracle jdk
# sudo apt-get -y install oracle-java7-installer
# sudo apt-get -y install oracle-java8-installer

# install nvm
curl --insecure -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash

# install docker
# sudo apt-get -y install docker.io apparmor
wget -qO- https://get.docker.com/ | sh

cp $HOME/share/dotfiles/bin/* $HOME/bin/
mkdir -p $HOME/share/certs
openssl req -new -x509 -keyout $HOME/share/certs/insecure_server.pem -out $HOME/share/certs/insecure_server.pem -days 365 -nodes -subj '/C=JP/ST=Tokyo'

local MVN_DIR=$HOME/opt/maven
mkdir -p ${MVN_DIR}
wget http://www.us.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.zip
unzip apache-maven-3.3.9-bin.zip
mv apache-maven-3.3.9 ${MVN_DIR}/3.3.9
ln -s -f ${MVN_DIR}/3.3.9/bin/mvn $HOME/bin/mvn
rm apache-maven-3.3.9-bin.zip

local SBT_DIR=$HOME/opt/sbt
mkdir -p ${SBT_DIR}
wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.11/sbt-0.13.11.tgz
tar xzf sbt-0.13.11.tgz
mv sbt ${SBT_DIR}/0.13.11
ln -s -f ${SBT_DIR}/0.13.11/bin/sbt $HOME/bin/sbt
rm sbt-0.13.11.tgz

local GRADLE_DIR=$HOME/opt/gradle
mkdir -p ${GRADLE_DIR}
wget https://services.gradle.org/distributions/gradle-2.9-bin.zip
unzip gradle-2.9-bin.zip
mv gradle-2.9 ${GRADLE_DIR}/2.9
ln -s -f ${GRADLE_DIR}/2.9/bin/gradle $HOME/bin/gradle
rm gradle-2.9-bin.zip

# Ricty install
mkdir -p $HOME/.fonts/migu-1m
sudo apt-get install -y fontforge fonts-inconsolata unzip
wget http://jaist.dl.sourceforge.jp/mix-mplus-ipa/59022/migu-1m-20130617.zip
unzip migu-1m-20130617.zip
mv migu-1m-20130617/*.ttf $HOME/.fonts/migu-1m
fc-cache -vf
rm -rf migu-1m-20130617.zip
rm -rf migu-1m-20130617

mkdir -p $HOME/.fonts/Ricty
mkdir -p $HOME/tmp/Ricty
cd $HOME/tmp/Ricty
cp $HOME/.fonts/migu-1m/*.ttf $HOME/tmp/Ricty/
wget -O $HOME/tmp/Ricty/Inconsolata.zip https://www.google.com/fonts/download?kit=CNj0Ze1H6w4FVgc32wmZS4fD-WQWLbF4rYwcBGowFYY
unzip $HOME/tmp/Ricty/Inconsolata.zip
wget -O $HOME/tmp/Ricty/ricty_generator.sh http://www.rs.tus.ac.jp/yyusa/ricty/ricty_generator.sh
chmod 755 $HOME/tmp/Ricty/ricty_generator.sh
$HOME/tmp/Ricty/ricty_generator.sh auto
cp $HOME/tmp/Ricty/Ricty*.ttf $HOME/.fonts/Ricty/
fc-cache -vf
rm -rf $HOME/tmp/Ricty

}

do_install
