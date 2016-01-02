#!/bin/bash
# setup_vim - Download and install correctly all vim plugins using Vundle


#####################################
# Create undo folder
#####################################
undo_path="$HOME/.vim_undo"
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

fi

#################################
# Install all the plugins
#################################

vim +PluginInstall +qall

###########################################
# Compile YouCompleteMe
# NOTE : We need cmake & python2 for YCM
###########################################


# Find python2
py2="python"

case "$(python -V 2>&1)" in

	*" 2."*)
		# The python exec is for python2, continue..
		;;
	*)
		# Need to find python v2
		if [ -x "$(command -v python2)" ]; then
			py2="python2" # python2 found
		else
			# python2 not found, install it
			if [ -x "$(command -v pacman)" ]; then
				echo "Python2 not found, installing via pacman..."
				sudo pacman -S python2

				if [ -x "$(command -v python2)" ]; then
					py2="python2" # python2 installed correctly
				else
					echo "python2 not installed correctly, need to install it to continue."
					exit
				fi
			else
				echo "python2 not found, need to install it!"
				exit
			fi
		fi
		;;
esac

# Making sure we have 'cmake'

if [ ! -x "$(command -v cmake)" ]; then
	if [ -x "$(command -v pacman)" ]; then
		echo "'cmake' not found, installing it via pacman..."
		sudo pacman -S cmake

		if [ ! -x "$(command -v cmake)" ]; then
			echo "'cmake' not installed correctly, need to install it to compile YCM."
			exit
		fi

	else
		echo "'cmake' not found, need to install it to compile YCM."
		exit
	fi

fi

echo "Compiling YouCompleteMe..."
# See documentation at : http://github.com/Valloric/YouCompleteMe#installation
$py2  $HOME/.vim/bundle/YouCompleteMe/install.py

###########################################
# Install 'jshint' globally with NPM for linting
###########################################

if [ ! -x "$(command -v jshint)" ]; then
	echo "Install JSHINT globally with npm for 'scrooloose/syntastic' linting"
	sudo npm install -g jshint
fi

##########################################
# Install ctags to use tagbar plugin
##########################################


if [ ! -x "$(command -v ctags)" ]; then
	if [ -x "$(command -v pacman)" ]; then
		echo "'ctags' not found, installing it via pacman..."
		sudo pacman -S ctags

		if [ ! -x "$(command -v ctags)" ]; then
			echo "'ctags' not installed correctly, need to install it to use 'tagbar' plugin."
			exit
		fi

	else
		echo "'ctags' not found, need to install it to use 'tagbar' plugin."
		exit
	fi
fi
