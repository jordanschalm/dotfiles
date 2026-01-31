#!/bin/sh
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare git@github.com:jordanschalm/dotfiles.git $HOME/.dotfiles
dotfiles checkout
