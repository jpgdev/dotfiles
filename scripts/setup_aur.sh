#!/bin/bash
# setup_aur.sh - Download and install yay to use the AUR

# TODO: Find a better path for the binary
yay_path=~/tmp/yay

# TODO: Make sure GIT is installed?
git clone https://aur.archlinux.org/yay.git ${yay_path}

cd ${yay_path}

# build the package
makepkg -si

# yay is now ready

