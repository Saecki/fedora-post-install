#!/bin/sh

install() {
    dl_dir=$(mktemp -d)

    wget -O "$dl_dir/mmc.tar.gz" https://files.multimc.org/downloads/mmc-stable-lin64.tar.gz

    sudo rm -rf /opt/MultiMc
    sudo tar xzf "$dl_dir/mmc.tar.gz" -C /opt/

    sudo /usr/local/bin/create-desktop-file \
    -e /opt/MultiMC/MultiMC \
    -n MultiMC \
    -g org.MultiMC
}

update() {
    echo "let MultiMC update itself"
}

. "$(dirname $(dirname $(dirname $(realpath $0))))/util/manage.sh"

