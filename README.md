# Development Environment

This is a general guide for setting up development environement using `vim` on Mac OS X for both Python and Go (golang).

While there are alot of GUI based IDE's available, as a network engineer I spend most of my time in terminals on various operating systems (Windows, Linux and Mac) and find the ubiquity of vim on all platforms (anywhere you can initiate SSH to a remote terminal) to be a valuable tool.

This is my own guide so that I can repeat the setup easily.

### Documentation

Most projects come with a README, these are usually written in Markdown or reStructuredText.  Here are two Markdown editors for Mac OS X that support a live preview and behave similar to a regular document editor.

- *Typora* for Mac OS X is [here](https://www.typora.io/)
- *MacDown* for Mac OS X is [here](http://macdown.uranusjr.com)

Currently I am using Typora with great success.

### Vim

Install Vim using `brew`

- `brew update`
- `brew install vim`

Had to restart bash after installing new vim

- `/usr/local/bin/` should appear before `/usr/bin/` in your PATH
- Check vim vesion with `vim --version` it should be **7.4**.


Vim plugins

- `mkdir ~/.vim/bundle/`


- `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

### Fonts

Having a good font is important and there seems to be some well known font issues with vim Powerline plugin with iTerm on Mac OS X.

- Install fonts (iTerm issues with vim Plugin Powerline)
- `git clone https://github.com/powerline/fonts.git`
- `cd fonts`
- `./install.sh`
- Make sure you go into iTerm and chage the font to 
  - Preferences -> Profiles -> Default -> Text
    - Inconsolata for Powerline

### YouCompleteMe

This an autocompletion plugin for vim and supports Python and Go.

- Install through vundle Plugin
  - Edit `.vimrc` adding `Plugin 'Valloric/YouCompleteMe'`
  - Save and restart vim or reload `.vimrc`
  - In vim run `:PluginInstall`
- `cd ~/.vim/bundle/YouCompleteMe/`
- `./install.py --gocode-completer --clang-completer`



### Colours

- `git clone https://github.com/fatih/molokai.git`
- `git clone https://github.com/jnurmine/Zenburn.git`
- `git clone https://github.com/altercation/vim-colors-solarized.git`
- `git clone https://github.com/morhetz/gruvbox.git`

Each *.vim* file should be placed in the `~/.vim/colors/` directory.

Some of the colors can be installed as Plugins

```
Plugin 'morhetz/gruvbox'
Plugin 'haensl/mustang-vim'
```

The colour scheme can then be set in `.vimrc`

```
colorscheme mustang
```

### Python

Python is well known interpreted language used for many tasks, for simple tasks through to full applications.  It used by network engineers for orchestration, automation, monitoring and reporting.

Python does have some challenges including (but certainly not limited to):

- it's environment (i.e. virtualenv)
- multiprocessing (it has improved but stil is not part of Python's core)
- memory foot print

### Python and Vim

- Create a `~/.vim/ftplugin/` directory
- `vim ~/.vim/ftplugin/python.vim`

```
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=100  " Set the terminal width to 100, a more modern approach
setlocal smarttab
setlocal expandtab
```

### Go

Go is a systems programming language introduced by Google.  It has several benefits over other languages and generally sits somewhere between a interpreted and a compiled language.

- Install using brew
  - `brew update`

  - `brew install go`


After installing Go you can look at the documentation offline simply by running:

- `godoc -http=:6060` 

Alternatively you can do the *tour*… it will run a server on the localhost on 127.0.0.1:3999.

- `gotour`

To ensure Go has the necessary binaries within vim run:

- `:GoInstallBinaries`

#### Resources

##### Concurrency

- http://divan.github.io/posts/go_concurrency_visualize/



### Go and Vim

- `:GoFmt` will correct any format errors (like PEP8 for Go), and should be run automatically when `:w` (on save) when using vim-go.
- Install tagbar
  - `brew install ctags`
  - Add the following Plugins to the `.vimrc`

```
Plugin 'jstemmer/gotags'
Plugin 'majutsushi/tagbar'
```

### Go Resources

- Concurrency
  - https://talks.golang.org/2013/advconc.slide#1
  - https://talks.golang.org/2012/concurrency.slide#1



### Go and Networking

#### Examples

- Ping pong https://gist.github.com/kenshinx/5796276
- GoDoc ICMP https://godoc.org/golang.org/x/net/icmp
- ​

#### Multicast

##### Resources

- http://dave.cheney.net/2011/02/19/using-multicast-udp-in-go
- https://gist.github.com/fiorix/9664255

Basic example of Multicast

```go
package main

import (
	"encoding/hex"
	"log"
	"net"
	"time"
)

const (
	srvAddr         = "224.0.0.1:9999"
	maxDatagramSize = 8192
)

func main() {
	go ping(srvAddr)
	serveMulticastUDP(srvAddr, msgHandler)
}

func ping(a string) {
	addr, err := net.ResolveUDPAddr("udp", a)
	if err != nil {
		log.Fatal(err)
	}
	c, err := net.DialUDP("udp", nil, addr)
	for {
		c.Write([]byte("hello, world\n"))
		time.Sleep(1 * time.Second)
	}
}

func msgHandler(src *net.UDPAddr, n int, b []byte) {
	log.Println(n, "bytes read from", src)
	log.Println(hex.Dump(b[:n]))
}

func serveMulticastUDP(a string, h func(*net.UDPAddr, int, []byte)) {
	addr, err := net.ResolveUDPAddr("udp", a)
	if err != nil {
		log.Fatal(err)
	}
	l, err := net.ListenMulticastUDP("udp", nil, addr)
	l.SetReadBuffer(maxDatagramSize)
	for {
		b := make([]byte, maxDatagramSize)
		n, src, err := l.ReadFromUDP(b)
		if err != nil {
			log.Fatal("ReadFromUDP failed:", err)
		}
		h(src, n, b)
	}
}
```

