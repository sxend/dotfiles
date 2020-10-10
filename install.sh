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
  mkdir -p $HOME/var/log

  if [ -d "$HOME/Downloads" ]; then
    ln -s $HOME/Downloads $HOME/downloads
  else
    mkdir -p $HOME/downloads
  fi

  cd $HOME/tmp

  # update apt
  sudo apt-get -y update

  # install basic packages
  sudo apt-get -y install wget curl vim zsh git unzip build-essential gdebi pkg-config libssl-dev

  TEMP_DEB="$(mktemp)" && \
    wget -O "$TEMP_DEB" 'https://update.code.visualstudio.com/latest/linux-deb-x64/stable' && \
    sudo gdebi "$TEMP_DEB" && \
    rm -f "$TEMP_DEB"

  local IDEA_DIR=$HOME/opt/idea
  mkdir -p ${IDEA_DIR}
  local IDEA_VERSION=ideaIU-2020.2.3
  
  wget -O ./${IDEA_VERSION}.tar.gz https://download-cf.jetbrains.com/idea/${IDEA_VERSION}.tar.gz
  tar xzf ./${IDEA_VERSION}.tar.gz -C ${IDEA_DIR}
  ln -v -s -f ${IDEA_DIR}/$(bash -c 'ls $HOME/opt/idea | sort | tail -1')/bin/idea.sh $HOME/bin/idea.sh

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

  # install java version manager
  curl --insecure -sL https://raw.githubusercontent.com/shyiko/jabba/0.11.2/install.sh | bash && . ~/.jabba/jabba.sh

  # install nvm
  curl --insecure -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash

  # setup rust environment
  curl --insecure https://sh.rustup.rs -sSf | sh -s -- -y
  echo 'export PATH=$PATH:$HOME/.cargo/bin' >> $HOME/.zshrc.include
  $HOME/.cargo/bin/rustup component add rustfmt
  $HOME/.cargo/bin/rustup component add clippy
  $HOME/.cargo/bin/rustup target add x86_64-unknown-linux-musl
  $HOME/.cargo/bin/cargo install cargo-edit

  # install docker
  wget -qO- https://get.docker.com/ | sh
  sudo usermod -aG docker `whoami`

  cp $HOME/share/dotfiles/bin/* $HOME/bin/
  mkdir -p $HOME/share/certs
  openssl req -new -x509 -keyout $HOME/share/certs/insecure_server.pem -out $HOME/share/certs/insecure_server.pem -days 365 -nodes -subj '/C=JP/ST=Tokyo'

  local MVN_DIR=$HOME/opt/maven
  local MVN_VERSION=3.6.3
  mkdir -p ${MVN_DIR}
  wget http://www.us.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.zip
  unzip apache-maven-${MVN_VERSION}-bin.zip
  mv apache-maven-${MVN_VERSION} ${MVN_DIR}/${MVN_VERSION}
  ln -s -f ${MVN_DIR}/${MVN_VERSION}/bin/mvn $HOME/bin/mvn
  rm apache-maven-${MVN_VERSION}-bin.zip

  local SBT_DIR=$HOME/opt/sbt
  local SBT_VERSION=1.4.0
  mkdir -p ${SBT_DIR}
  wget https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz
  tar xzf sbt-${SBT_VERSION}.tgz
  mv sbt ${SBT_DIR}/${SBT_VERSION}
  ln -s -f ${SBT_DIR}/${SBT_VERSION}/bin/sbt $HOME/bin/sbt
  rm sbt-${SBT_VERSION}.tgz

  local GRADLE_DIR=$HOME/opt/gradle
  local GRADLE_VERSION=6.6.1
  mkdir -p ${GRADLE_DIR}
  wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
  unzip gradle-${GRADLE_VERSION}-bin.zip
  mv gradle-${GRADLE_VERSION} ${GRADLE_DIR}/${GRADLE_VERSION}
  ln -s -f ${GRADLE_DIR}/${GRADLE_VERSION}/bin/gradle $HOME/bin/gradle
  rm gradle-${GRADLE_VERSION}-bin.zip

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

  sudo apt-get -y upgrade
}

do_install
