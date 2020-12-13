#!/bin/bash
# setup_vim_base - Setup vim folders, setup vundle and correctly all vim plugins using Vundle

script_path="$(dirname $(readlink -f $0))"
# This takes the current folder path, then removes the last part,
# which should be the scripts folder and returns the full path
git_folder_path=${script_path%/*}/.git

#####################################
# Create tmp folder for undo & swap
#####################################

tmp_path="$HOME/.vim/tmp"
swap_path="$tmp_path/swap"
undo_path="$tmp_path/undo"

if [ ! -d $tmp_path ]; then
    echo "Create the vim tmp directory ($tmp_path)."
    mkdir $tmp_path
fi
if [ ! -d $swap_path ]; then
    echo "Create the vim swap directory ($swap_path)."
    mkdir $swap_path
fi
if [ ! -d $undo_path ]; then
    echo "Create the vim undo directory ($undo_path)."
    mkdir $undo_path
fi

#####################################
# Acquiring Vundle to setup our plugins
#####################################

# If Vundle has not been downloaded yet
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]
then
    echo "Vundle was not found, getting it from github"
    git clone https://github.com/VundleVim/vundle.vim.git $HOME/.vim/bundle/Vundle.vim
else
    # We assume it's there but as a submodule, so we update it correctly
    git --git-dir $git_folder_path submodule init 
    git --git-dir $git_folder_path submodule update
fi

#################################
# Install all the plugins
#################################

vim +PluginInstall +qall
