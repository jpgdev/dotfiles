pacman -Qqe | grep -v "$(pacman -Qmq)" > pkglist
