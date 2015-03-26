" .vimrc
" Jean-Philippe Goulet

" Inspired by : https://github.com/cabouffard/dotfiles

" ======== Get current OS

let os = ""
if has("win32")
	let os = "win"
else
	let os = substitute(system('uname'), "\n", "", "")
endif

" ======== Plugins (with Vundle) {{{

set nocompatible
filetype off

if os == "win"
	set rtp+=~/vimfiles/bundle/Vundle.vim/
	let path='~/vimfiles/bundle'
	call vundle#begin(path)
else
	set rtp+=~/.vim/bundle/Vundle.vim/
	call vundle#begin()
endif

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
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" Plugin 'suan/vim-instant-markdown'
Plugin 'rking/ag.vim'

" Themes
" Plugin 'tomasr/molokai'
" Plugin 'altercation/vim-colors-solarized'
Plugin 'flazz/vim-colorschemes' " Adds lots of themes

" Language specific plugins
Plugin 'jelera/vim-javascript-syntax'

" GIT Related plugins
Plugin 'airblade/vim-gitgutter' " Shows git diff in the left panel
Plugin 'tpope/vim-fugitive' " Allows multiple GIT operation from inside vim

Plugin 'mattn/gist-vim' " Allow to post gist easily
Plugin 'mattn/webapi-vim' " WEBAPI used by gist-vim

" Snipmate required plugins
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
" Plugin 'honza/vim-snippets'
"

call vundle#end()


"}}}

" ======== Plugins configs

" vim-markdown
let g:vim_markdown_folding_disabled=1 " disable the collapse

" vim-airline
set laststatus=2 "Is required or the status bar does not appear in th first vim split opened
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers at the top
let g:airline#extensions#tabline#fnamemod = ':t' " Just show the filename (no path) in the tab

" Enable Rainbow Parentheses at startup
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Change snipmate keybind
" imap <C-Space> <Plug>snipMateNextOrTrigger
" smap <C-Space> <Plug>snipMateNextOrTrigger

" Use Ag (the_silver_surfer)
if executable('ag')

	" Use Ag instead of grep
	set grepprg=ag\ --nogroup\ --nocolor

	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

endif

" ======== Generic Settings

" Highlight the current line
set cursorline

" Tabulation related settings
set autoindent
set smarttab

" 2 spaces for tabulations
set shiftwidth=2
set tabstop=2

" Line numbering
set number

" Highlight trailing whitespace
match ErrorMsg '\s\+$'

" When opening a new split, it opens below & on the right
set splitbelow
set splitright

set showcmd " Show the current command on the lower right, like the  <leader> key

let mapleader=","  " Set the <leader> to , instead of \

if os == "Linux"
	set undofile " tell it to use an undo file
	set undodir=/home/jp/.vim_undo/ " set a directory to store the undo history
endif

" ======== Buffers related options

" This allows buffers to be hidden if you've modified a buffer.
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

if os == "win"
	" Witchcraft to fix the 256 colors scheme in Windows
	set term=xterm
	let &t_AB="\e[48;5;%dm"
	let &t_AF="\e[38;5;%dm"
endif

" To be able to have 256 color sceme
set t_Co=256
let g:rehash256 = 1


syntax on
set background=dark

colorscheme molokai

" Transparent background
" highlight Normal ctermbg=none
" highlight NonText ctermbg=none

filetype indent plugin on

