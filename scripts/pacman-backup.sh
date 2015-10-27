pacman -Qqe | grep -v "$(pacman -Qmq)" > pkglist
yaourt -Qqe | grep -v "$(yaourt -Qmq)" > pkglist.aur
