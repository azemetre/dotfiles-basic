#!/usr/bin/env bash

# Install command-line tools using Homebrew

# Make sure brew is updated
brew update

# Upgrade any installed formulae
brew upgrade

# Save brew installed location
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (macOS defaults are outdated)
# add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install other useful utilities
brew install moreutils
brew install findutils
brew install bash
brew install bash-completion2
brew install wget --with-iri
brew install gnupg
brew install gettext
brew install pcre
brew install pcre2
brew install oniguruma
brew install libidn2
brew install xz
brew install msgpack
brew install openssl
brew install gdbm
brew install readline

# Install more recent versions of macOS tools
brew install vim --with-override-system-vi
brew install git
brew install grep
brew install openssh
brew install screen
brew install php
brew install gmp

# Install shells
brew install zsh
brew install powerlevel9k

# Install lanuages
brew install python
brew install python@2
brew install node
brew install go
brew install openjdk
brew install scala
brew install sbt
brew install lua
brew install luajit

# Install dependencies for other tools
brew install libvterm
brew install libuv
brew install libtermkey
brew install unibilium
brew install icu4c
brew install libunistring
brew install ncurses

# Install new-age command-line tools
brew install jq
brew install fzf
brew install httpie
brew install bat
brew install ripgrep
brew install fd
brew install hyperfine
brew install pastel
brew install hexyl
brew install diskus
brew install imagemagick
brew install homeshick

# Install software
brew install neovim
brew install sqlite

# Remove outdated version from the cellar
brew cleanup
