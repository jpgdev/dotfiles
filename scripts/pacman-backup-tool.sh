#!/bin/bash
# pacbac - Create and restore from list all installed packages
# Source : https://bbs.archlinux.org/viewtopic.php?id=76218

# Package list locations (official and local)
pkglsoff=~/pacman.pkg
pkglsloc=~/pacman.aur.pkg

# Exclude packages
excldoff=()
excldloc=()

# Use filename as program name
prog=${0##*/}

# Text color variables
bldblu='\e[1;34m'         # blue
bldred='\e[1;31m'         # red
bldwht='\e[1;37m'         # white
txtcyn='\e[0;36m'         # cyan
txtund=$(tput sgr 0 1)    # underline
txtrst='\e[0m'            # text reset
info=${bldwht}*${txtrst}
pass=${bldblu}*${txtrst}
warn=${bldred}!${txtrst}

# If restoring, be sure yay is installed
if [[ "$1" == 'r' ]] && [[ -z $(pacman -Qs yay) ]]; then
	echo ""
	echo -e "$warn $prog requires ${txtund}}yay${txtrst} to be installed."
	echo -e "  ${txtcyn}http://wiki.archlinux.org/index.php/yay${txtrst}"
	echo ""
	exit
fi

case $1 in
	-b ) # Create list of official repository packages (core, extra, community)
		echo -e "$info Creating list of official (core/extra/community packages) packages installed."
		# Create list, remove local, base
		pacman -Qqe | grep -vx "$(pacman -Qqg base)" | grep -vx "$(pacman -Qqm)" > "$pkglsoff"
		# Create list of local packages (includes the AUR)
		echo -e "$info Creating list of local (includes AUR) packages installed."
		pacman -Qqm > "$pkglsloc"
		echo -e "$pass Official package list saved to ${txtund}"$pkglsoff"${txtrst}"
		echo -e "$pass Local package list saved to ${txtund}"$pkglsloc"${txtrst}" ;;
	-r )  # Update repository database, then restore packages from list
		echo -e "$info Installing packages from lists"
		sudo pacman -Sy
		# use -f to overwrite conflicting files
		sudo pacman -S --needed $(cat "$pkglsoff")
		# yay doesn't have --needed check
		yay -S $(cat "$pkglsloc" | grep -vx "$(pacman -Qqm)") ;;
	* ) echo -e " -b : build installed packages list. (dir:${txtund}"${pkglsoff%/*}"${txtrst})"
		echo -e " -r : restore installed packages from package list." ;;
esac
