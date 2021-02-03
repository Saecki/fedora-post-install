#!/bin/sh

install() {
    dl_dir=$(mktemp -d)

    wget -P $dl_dir https://files.multimc.org/downloads/mmc-stable-lin64.tar.gz

    sudo rm -rf /opt/MultiMc
    sudo tar xzf "$dl_dir/mmc-stable-lin64.tar.gz" -C /opt/

    rm -rf $dl_dir

    sudo /usr/local/bin/create-desktop-file \
	-e /opt/MultiMC/MultiMC \
	-n MultiMC \
    -g org.MultiMC
}

update() {
    echo "Let MultiMC update itself or reinstall it"
}

. "$(dirname $(dirname $(realpath $0)))/util/manage.sh"