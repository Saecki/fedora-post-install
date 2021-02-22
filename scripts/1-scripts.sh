#!/bin/bash

install() {
    sudo git clone --bare git@github.com:Saecki/scripts /usr/local/bin/.scripts
    sudo git --work-tree=/usr/local/bin/ --git-dir=/usr/local/bin/.scripts checkout -f
}

update() {
    sudo git --work-tree=/usr/local/bin/ --git-dir=/usr/local/bin/.scripts pull origin master
    sudo git --work-tree=/usr/local/bin/ --git-dir=/usr/local/bin/.scripts checkout -f
}

. "$(dirname $(dirname $(realpath $0)))/util/manage.sh"
