#!/bin/sh

. "$(dirname $0)/print.sh"

for file in "$@"; do
    if [[ $file == *.gsettings ]]; then
        heading2 "applying settings from $file"

        schemadir=""
        while read -r line; do
            if [[ $line == schemadir:* ]]; then
                schemadir=$(eval "echo ${line#schemadir:}")
                heading3 "custom schemadir: $schemadir"
            elif [[ $line != "" ]] && [[ $line != "#"* ]]; then
                echo "$line"

                if [[ $schemadir != "" ]]; then
                    gsettings --schemadir $schemadir set $line
                else
                    gsettings set $line
                fi
            fi
        done < "$file"

    fi
done

