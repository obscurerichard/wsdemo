.PHONY: all apt-get-update client client-env config go-deps \
	perl-deps python-deps ruby-deps report server server-deps stats

all:
	@echo "syntax: make <server|client>"

apt-get-update:
	sudo apt-get update

client: client-env
	./rebar get-deps compile

client-env: apt-get-update
	sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
		build-essential \
		curl \
		erlang-dev \
		erlang-nox \
		git \
		libadns1-dev \
		libevent-dev \
		unzip

config:
	sudo cp etc/sysctl.conf /etc/
	sudo sysctl -p

go-deps:
	sudo go get code.google.com/p/go.net/websocket

haskell-deps:
	sudo cabal update
	sudo cabal install snap-server snap-core websockets websockets-snap

perl-deps:
	sudo cpanm \
		EV \
		EV::ADNS \
		IO::Stream \
		Protocol::WebSocket \
		YAML

python-deps:
	sudo easy_install \
		gevent \
		gevent-websocket \
		pip \
		priv/wsdemo_monitor \
		supervisor \
		tornado \
		twisted \
		txws \
		ws4py

report:
	./bin/compile_all_stats.sh

ruby-deps:
	sudo gem install em-websocket --no-ri --no-rdoc

server: server-deps config
	$(MAKE) -C competition server

server-env: apt-get-update
	sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
		build-essential \
		curl \
		cpanminus \
		emacs \
		erlang-dev \
		erlang-nox \
		git \
		golang \
		haskell-platform \
		libadns1-dev \
		libevent-dev \
		mercurial \
		openjdk-7-jdk \
		python-dev \
		python-setuptools \
		ruby \
		rubygems \
		unzip

server-deps: server-env \
	haskell-deps perl-deps python-deps ruby-deps

stats:
	$(MAKE) -C stats stats
