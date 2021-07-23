#!/bin/bash

_install_path=$HOME/.dotfiles/swpackages

# =============================================================
#  Help menu.
# =============================================================
helpMenu()
{
    echo "Backup packages from pacman and AUR."
    echo
    echo "options:"
    echo -e "-b           Backup the installed pacman and AUR packages."
    echo -e "-h           Display this help and exit."
    echo

    exit 0
}

backupPkgs()
{
    if [[ ! -d "${_install_path}" ]]; then
        mkdir -p "${_install_path}"
    fi

    pacman -Qqe > "${_install_path}/pacman-pkg.txt" && pacman -Qqem > "${_install_path}/aur-pkg.txt"
    cp /etc/pacman.conf "${_install_path}/"
}

while getopts "brh" op; do
    case $op in
        b) backupPkgs
           ;;
        [?]| h) # display Help
            helpMenu
            ;;
    esac
done
