#!/bin/bash
############################
# setup_dotfiles.sh
# This script creates symlinks from the home directory to any desired dotfiles in $HOME/dotfiles
# SOURCE: http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
############################

########## Variables

dotfiles_location=$1  # Use the first param as dotfiles location
# Use the default path, if none is provided
if [ -z "$dotfiles_location" ]; then
    dotfiles_location=$HOME/dotfiles
fi

backup_dir=$HOME/dotfiles_old             # old dotfiles backup directory

# list of files/folders to symlink in $HOME
files="
Xresources
archey3.cfg
bashrc
conkyrc
gitconfig
gitignore_global
livestreamerrc
npmrc
oh-my-zsh
tern-config
tmux.conf
vim
vimrc
xinitrc
zshrc
"

# Colors
red=$'\e[1;31m'
green=$'\e[1;32m'
yellow=$'\e[1;33m'
blue=$'\e[1;34m'
end=$'\e[0m'

##########

echo -e "${green} Symlinking and backing up dotfiles\n"

# Create $backup_dir
mkdir -pv $backup_dir

# Move any existing dotfiles in $HOME to dotfiles_old directory, then create symlinks
for file in $files; do
    initial_file=$HOME/.$file
    need_backup=false

    echo -e "${yellow}.$file${end}"

    # the file already exists
    if [ -e $initial_file ]; then
        need_backup=true
    else
        # the file is a broken symlink, still keep it in case
        # WHY?: It is a symlink, but not seen as a file
        if [ -L $initial_file ]; then
            echo -e "\t${red}Broken symlink found at $initial_file${end}"
            need_backup=true
        fi
    fi

    if [ $need_backup ]; then
        echo -e "\tBacking up $initial_file -> $backup_dir/.$file"
        mv $initial_file $backup_dir
    fi

    target_location=$dotfiles_location/$file

    ln -s $target_location $initial_file
    echo -e "\tSymlinking $initial_file -> $target_location"
done

echo -e "${green} DONE!${end}"
