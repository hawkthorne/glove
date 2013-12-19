.PHONY: test clean

UNAME := $(shell uname)

ifeq ($(UNAME), Darwin)
ifeq ($(LOVE_VERSION), 0.9.0)
  LOVE = love9.app/Contents/MacOS/love
else
  LOVE = love8.app/Contents/MacOS/love
endif
else
ifeq ($(LOVE_VERSION), 0.9.0)
  LOVE = /usr/bin/love9
else
  LOVE = /usr/bin/love8
endif
endif

ifeq ($(shell which wget),)
  WGET = curl -s -O -L
else
  WGET = wget -q --no-check-certificate
endif

test: $(LOVE)
	rm -rf "$($HOME)/Library/Application Support/LOVE/glove"
	cp glove.lua test/glove.lua
	$(LOVE) test

all:
	LOVE_VERSION=0.8.0 make test
	LOVE_VERSION=0.9.0 make test

love8.app/Contents/MacOS/love:
	$(WGET) https://bitbucket.org/rude/love/downloads/love-0.8.0-macosx-ub.zip
	unzip -q love-0.8.0-macosx-ub.zip
	rm -f love-0.8.0-macosx-ub.zip
	mv love.app love8.app


love9.app/Contents/MacOS/love:
	$(WGET) https://bitbucket.org/rude/love/downloads/love-0.9.0-macosx-x64.zip
	unzip -q love-0.9.0-macosx-x64.zip
	rm -f love-0.9.0-macosx-x64.zip
	mv love.app love9.app

/usr/bin/love8:
	wget https://bitbucket.org/rude/love/downloads/love_0.8.0-0precise1_amd64.deb
	-sudo dpkg -i love_0.8.0-0precise1_amd64.deb
	sudo apt-get update -y
	sudo apt-get install -f -y
	sudo ln -s /usr/bin/love /usr/bin/love8

/usr/bin/love9:
	sudo add-apt-repository -y ppa:bartbes/love-stable
	sudo apt-get update -y
	sudo apt-get install -y love
	sudo ln -s /usr/bin/love /usr/bin/love9

clean:
	rm -rf love8.app
	rm -rf love9.app
