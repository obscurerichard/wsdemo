.PHONY: all clean distclean node-deps node-ws play pypy server

all: EchoWsServer.class node-deps play pypy wsdemo.beam wsdemo-snap wsdemo-go-gonet

clean:
	rm f- *.class *snap.hi *snap.o wsdemo-snap *.beam wsdemo-go-gonet
	$(MAKE) -C wsdemo-playframework-2 clean

distclean: clean
	sudo rm -rf pypy-1.9 node-v0.8.21 distribute*.tar.gz wsdemo-playframework-2 /usr/local/bin/node /usr/local/bin/npm

# Erlang
wsdemo.beam:
	erlc wsdemo.erl

# Go
wsdemo-go-gonet: wsdemo.go
	go build -o wsdemo-go-gonet wsdemo.go

# Haskell
wsdemo-snap: wsdemo-snap.hs
	ghc -rtsopts --make -O2 -threaded wsdemo-snap.hs

# Java
EchoWsServer.class: EchoWsServer.java
	javac -cp webbit-0.4.7-full.jar EchoWsServer.java

# Scala
play: wsdemo-playframework-2/dist/wsdemo-1.0-SNAPSHOT.zip

wsdemo-playframework-2/dist/wsdemo-1.0-SNAPSHOT.zip:
	unzip -u play-2.0.1.zip
	$(MAKE) -C wsdemo-playframework-2

# Node.JS
node-deps: /usr/local/bin/node node-ws

/usr/local/bin/node:
	tar xzf node-v0.8.21.tar.gz
	cd node-v0.8.21 && ./configure && make && sudo make install

node-ws:
	npm install websocket ws

# Python
pypy: pypy-1.9/bin/pypy

pypy-1.9/bin/pypy:
	tar xjf pypy-1.9-linux64.tar.bz2
	./pypy-1.9/bin/pypy distribute_setup.py
	./pypy-1.9/bin/easy_install pip
	./pypy-1.9/bin/pip install tornado ws4py twisted txws

