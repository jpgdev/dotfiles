" .vimrc

" ======== Plugins (with Vundle) {{{

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" ======== Add plugins here 

" Vim config plugins
Plugin 'bling/vim-airline'
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/rainbow_parentheses.vim'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Themes
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'

" GIT Related plugins
Plugin 'airblade/vim-gitgutter'

call vundle#end()

"}}}

" ======== Plugins configs

" vim-markdown
let g:vim_markdown_folding_disabled=1 " disable the collapse



" Tabulation related settings
set autoindent
set smarttab

" 2 spaces
set shiftwidth=2 
set tabstop=2

" Line numbering
set number


" ======== Custom Keybind mapping

:imap jj <Esc>


" ======== Set theme and colorscheme

set t_Co=256
let g:rehash256 = 1

syntax on 
set background=dark

colorscheme molokai

filetype indent plugin on


