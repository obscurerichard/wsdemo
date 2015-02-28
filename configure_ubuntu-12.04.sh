#!/bin/bash
# Note: pushd/popd only work in bash

# Use bash unofficial strict mode
set -eou pipefail
IFS=$'\n\t'
# Credit to Stack Overflow user Dave Dopson http://stackoverflow.com/a/246128/424301
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASENAME=$(basename $0)
REPO="git://github.com/ericmoritz/wsdemo.git"

# Allow repo to be cloned to be passed as argument
repo=${1:-}
if [[ -z "$repo" ]]; then
    repo="$REPO"
fi


sudo apt-get update
sudo apt-get install -y \
    curl emacs unzip python-dev python-setuptools build-essential erlang-nox erlang-dev \
    libevent-dev git golang mercurial openjdk-7-jdk ruby rubygems haskell-platform \
    cpanminus libadns1-dev pypy

sudo easy_install pip ws4py gevent gevent-websocket tornado twisted txws supervisor

if [ -f "/vagrant/$BASENAME" ]; then 
    echo "Running under vagrant, skipping git clone"
    WSDEMO="/vagrant"
else
    # Clone master
    git clone "$repo" wsdemo
    WSDEMO=wsdemo
fi

# Update sysctl
sudo cp "$WSDEMO"/etc/sysctl.conf /etc/
sudo sysctl -p

# install the wsdemo_monitor package
sudo easy_install "$WSDEMO"/priv/wsdemo_monitor

# install pypy
pushd "$WSDEMO"/competition
    sudo easy_install pip
    pip install tornado ws4py twisted txws
popd

# install Node
node=$(which node)
if [ "$node" == "" ]; then
  mkdir -p "$DIR"/src
  pushd "$DIR"/src
    curl http://nodejs.org/dist/v0.8.0/node-v0.8.0.tar.gz | tar xz
    pushd node-v0.8.0
      ./configure && make && sudo make install
    popd
  popd
fi

# install Play
pushd "$WSDEMO"/competition
   if [ ! -d ./play-2.0.1 ]; then
       curl -O http://download.playframework.org/releases/play-2.0.1.zip
       unzip play-2.0.1.zip
   fi
popd

# Node 0.8 has SSL certificate problems, ignore ssl cert checking
# See https://github.com/npm/npm/issues/4379
# (TODO: put in new certificate for https://registry.npmjs.org/)
npm conf set strict-ssl false
npm install websocket ws
sudo go get code.google.com/p/go.net/websocket
sudo gem install em-websocket

sudo cabal update
sudo cabal install snap-server snap-core websockets websockets-snap

sudo cpanm Protocol::WebSocket YAML EV EV::ADNS IO::Stream
