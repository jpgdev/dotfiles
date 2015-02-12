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
Plugin 'bling/vim-airline' " The statusbar plugin
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tomtom/tcomment_vim'

if os == "Linux"
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'marijnh/tern_for_vim' " JS smarter autocompletion with YCM
endif

Plugin 'kien/rainbow_parentheses.vim'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Themes
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'

" Language specific plugins
Plugin 'jelera/vim-javascript-syntax'

" Plugin 'garbas/vim-snipmate'

" GIT Related plugins
Plugin 'airblade/vim-gitgutter' " Shows git diff in the left panel
Plugin 'tpope/vim-fugitive' " Allows multiple GIT operation from inside vim

Plugin 'mattn/gist-vim' " Allow to post gist easily


call vundle#end()

"}}}

" ======== Plugins configs

" vim-markdown
let g:vim_markdown_folding_disabled=1 " disable the collapse

" vim-airline
set laststatus=2 "Is required or the status bar does not appear in th first vim split opened
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t'
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


" ======== Buffers related options

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>


" ======== Custom Keybind mapping

:imap jj <Esc>

" Splits
" Moving around splits
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

