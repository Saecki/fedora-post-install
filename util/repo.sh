#!/bin/sh

for file in $@; do
    if [[ $file == *.repo ]]; then
        echo -e "\ncopying $file to /etc/yum.repos.d/"
        sudo cp $file /etc/yum.repos.d/
    fi

    if [[ $file == *.install ]]; then
        while read line; do
            if [[ $line != "" ]] && [[ $line != "#"* ]]; then
                packages=$packages" $line"
            fi
        done < $file

        echo -e "\ninstalling repo $file:"
        sudo dnf install -y $packages

        packages=""
    fi

    if [[ $file == *.copr ]]; then
        echo -e "\nenabling copr repo $file:"
        while read line; do
            if [[ $line != "" ]] && [[ $line != "#"* ]]; then
                sudo dnf copr enable -y $line
            fi
        done < $file
    fi
done
