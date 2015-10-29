#!/bin/bash
# setup_aur.sh - Download and install yaourt to use the AUR

pacman_cfg_path="/etc/pacman.conf"

# Check if the archlinuxfr repo is already in the config file
# if not, add it
if [[ -z $(cat $pacman_cfg_path | grep "\[archlinuxfr\]") ]]; then
	echo "[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch" | sudo tee --append $pacman_cfg_path >> /dev/null
fi

sudo pacman -Sy yaourt --needed
