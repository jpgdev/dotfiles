" .vimrc
" Jean-Philippe Goulet

" Get OS
let os = substitute(system('uname'), "\n", "", "")

" ======== Plugins (with Vundle) {{{

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" ======== Add plugins here

" Vim config plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline' "The statusbar plugin
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tomtom/tcomment_vim'

if os == "Linux"
	Plugin 'Valloric/YouCompleteMe'
endif

" Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/rainbow_parentheses.vim'

"Plugin 'maciakl/vim-neatstatus'
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

" vim-airline
set laststatus=2

" ======== Generic Settings

" Tabulation related settings
set autoindent
set smarttab

" 2 spaces
set shiftwidth=2
set tabstop=2

" Line numbering
set number

" Highlight trailing whitespace
match ErrorMsg '\s\+$'

set splitbelow
set splitright

" ======== Custom Keybind mapping

:imap jj <Esc>

" Splits
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

" ======== Set theme and colorscheme

set t_Co=256
let g:rehash256 = 1

syntax on
set background=dark

colorscheme molokai

filetype indent plugin on

