#!/bin/sh

install() {
    LAUNCHTERM="$HOME/.local/bin/launch-kitty"

    oldkeybindings=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

    quotes="${oldkeybindings//[^\']}"
    amount="${#quotes}"

    if [[ $amount == "0" ]]; then
        oldkeybindings="["
    else
        oldkeybindings="${oldkeybindings::-1},"
    fi

    keybindings="$oldkeybindings"

    keybinding="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-term/"
    if [[ $keybindings != *"$keybinding"* ]]; then
        echo "adding launch-term keybinding"
        keybindings="$keybindings'$keybinding',"
    else
        echo "launch-term keybinding already present, updating it"
    fi

    tmuxkeybinding="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-term-tmux/"
    if [[ $keybindings != *"$tmuxkeybinding"* ]]; then
        echo "adding launch-term-tmux keybinding"
        keybindings="$keybindings'$tmuxkeybinding',"
    else
        echo "launch-term-tmux keybinding already present, updating it"
    fi

    keybindings="${keybindings::-1}]"

    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$keybindings"

    keybindingpath="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$keybinding"
    gsettings set $keybindingpath name "'Launch terminal'"
    gsettings set $keybindingpath command "'$LAUNCHTERM -T \"magic box\"'"
    gsettings set $keybindingpath binding "'<Super><Shift>Return'"

    tmuxkeybindingpath="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$tmuxkeybinding"
    gsettings set $tmuxkeybindingpath name "'Launch terminal tmux'"
    gsettings set $tmuxkeybindingpath command "'$LAUNCHTERM -T \"magic box\" -e tmux'"
    gsettings set $tmuxkeybindingpath binding "'<Super>Return'"
}

update() {
    install
}

. "$(dirname $(dirname $(dirname $(realpath $0))))/util/manage.sh"

