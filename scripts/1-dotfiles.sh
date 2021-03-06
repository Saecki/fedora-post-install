#!/bin/bash

git_dir="$HOME/.config/dotfiles"

install() {
    git clone --bare git@github.com:Saecki/dotfiles "$git_dir"
    git --work-tree="$HOME" --git-dir="$git_dir" checkout -f
}

update() {
    git --work-tree="$HOME" --git-dir="$git_dir" pull origin master
    git --work-tree="$HOME" --git-dir="$git_dir" checkout -f
}

. "$(dirname $(dirname $(realpath $0)))/util/manage.sh"

