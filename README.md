dotfiles
========

[![Build Status](https://travis-ci.org/christopher-hopper/dotfiles.svg?branch=master)](https://travis-ci.org/christopher-hopper/dotfiles)

Bourne Again Shell customisations and command configurations.

Installation
------------

To get up and running quickly use the following commands:

    # Backup any existing dotfiles folder.
    [[ -d ~/.dotfiles ]] && mv ~/.dotfiles ~/.dotfiles.original

    # Clone this project locally.
    git clone --recursive https://github.com/christopher-hopper/dotfiles.git ~/.dotfiles && cd $_

    # Run the installer script.
    ./install.sh -v

The install script has been tested on linux and macos. See the usage instructions for details
of the install script options.

    Usage:
       install.sh [-hnc] [-v|vv|vvv]
    
    Options:
       -h      Show this help.
    
       -v      More verbose output.
    
       -n      No changes but show result.
    
       -c      Force ANSI color output.

