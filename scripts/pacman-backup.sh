pacman -Qqe | grep -v "$(pacman -Qmq)" > pkglist
yay -Qqe | grep -v "$(yaourt -Qmq)" > pkglist.aur
