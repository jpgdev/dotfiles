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
	set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
	let path=$HOME.'~/vimfiles/bundle'
	call vundle#begin(path)
else
	set rtp+=$HOME/.vim/bundle/Vundle.vim/
	call vundle#begin()
endif

" ======== Add plugins here

" Vim config plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline' " The statusbar plugin
" Plugin 'mkitt/tabline.vim' " Better tab line (top)
Plugin 'scrooloose/nerdtree' " File explorer
Plugin 'kien/ctrlp.vim' " fuzzy find a file in the project
Plugin 'tomtom/tcomment_vim' " shortcut to comment code
" Plugin 'easymotion/vim-easymotion' " movement that behaves like the chrome vim plugin (when F is clicked)

if os == "Linux"
	Plugin 'Valloric/YouCompleteMe' " auto-completion
	Plugin 'marijnh/tern_for_vim' " JS smarter autocompletion with YCM
	Plugin 'suan/vim-instant-markdown' " Markdown previewer (requires the npm package instant-markdown-d)
endif

Plugin 'kien/rainbow_parentheses.vim'
Plugin 'tpope/vim-surround' " adds commands to modify surrounding characters
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" if ag (the_silver_searcher) is installed
if executable('ag')
	Plugin 'rking/ag.vim' " Better search tool than grep (requires AG package installed)
endif

" Plugin 'neilagabriel/vim-geeknote' " Integrate geeknote with vim (not working currently)
Plugin 'scrooloose/syntastic' " linting plugin. Uses external linters (ex. jshint) to work
Plugin 'drn/zoomwin-vim' " tool to enable focusing a single split
Plugin 'majutsushi/tagbar' " Browse a file tags (class layout etc..)
Plugin 'tpope/vim-dispatch'

" Themes
Plugin 'flazz/vim-colorschemes' " Adds lots of themes
" Plugin 'joshdick/onedark.vim' " Atom's One dark theme
" Plugin 'joshdick/airline-onedark.vim' " Atom's One dark airline theme

" Language specific plugins
Plugin 'jelera/vim-javascript-syntax'
Plugin 'ntpeters/vim-better-whitespace' " Show & Remove Whitespaces command
Plugin 'moll/vim-node' " Node.js
Plugin 'tmux-plugins/vim-tmux' " offers syntax highlight in tmux.conf file

" GIT Related plugins
Plugin 'airblade/vim-gitgutter' " Shows git diff in the left panel
Plugin 'tpope/vim-fugitive' " Allows multiple GIT operation from inside vim
Plugin 'mattn/gist-vim' " Allow to post gist easily
Plugin 'mattn/webapi-vim' " WEBAPI used by gist-vim

" Snipmate required plugins
" Plugin 'sirver/ultisnips' " ultisnips engine
" Plugin 'honza/vim-snippets' "ultisnips default snippets

" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
" Plugin 'honza/vim-snippets'

call vundle#end()

"}}}

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('bundle/matchit.vim', &rtp) ==# ''
	runtime! macros/matchit.vim
endif

" ======== Plugins configs

" vim-markdown
let g:vim_markdown_folding_disabled=1 " disable the collapse

" vim-instant-markdown
let g:instant_markdown_slow = 1 " Update the preview less often

" vim-airline
set laststatus=2 "Is required or the status bar does not appear in the first vim split opened
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers at the top
let g:airline#extensions#tabline#fnamemod = ':t' " Just show the filename (no path) in the tab
" let g:airline_theme='onedark'

" Enable Rainbow Parentheses at startup
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Change snipmate keybind
" imap <C-Space> <Plug>snipMateNextOrTrigger
" smap <C-Space> <Plug>snipMateNextOrTrigger

" vim-dispatch
" Set the compiler for vim-dispatch from the language
autocmd FileType javascript let b:dispatch = 'node %'


" tagbar
nmap <F8> :TagbarToggle<CR>

" scrooloose/syntastic (linting)
let g:syntastic_check_on_open=1 "Run linting on file open on top of when the file is saved

" Use Ag (the_silver_surfer)
if executable('ag')

	" Use Ag instead of grep
	set grepprg=ag\ --nogroup\ --nocolor

	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0

endif

" UltiSnips configs
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsForwardTrigger="<tab>"

" let g:ulti_expand_or_jump_res = 0
" " Function to be able to use snippets with YCM (press enter it generate the
" " snippet)
" function! <SID>ExpandSnippetOrReturn()
" 	let snippet = UltiSnips#ExpandSnippetOrJump()
" 	if g:ulti_expand_or_jump_res > 0
" 		return snippet
" 	else
" 		return "\<CR>"
" 	endif
" endfunction
"

" ======== Generic Settings
" Highlight the current line
set cursorline

" Tabulation related settings
set autoindent
set smarttab
set shiftwidth=2 " spaces for tabulations
set tabstop=2

" Case related settings
set ignorecase " ignore case by default
set infercase
set smartcase " will go case-sensitive if there is caps

set scrolloff=10 " keeps lines over or under the cursor at all time

" set backspace=indent,eol,start
set incsearch " start searching before clicking ENTER
set wildmenu " better autocompletion for : menu, adds a list of possible options on <TAB> press

" set clipboard=unnamed "link the vim clipboard with the OS (not working with  my version of vim)
" set colorcolumn=80 " Adds a column at 80 characters

" Line numbering
set number
" set relativenumber

" Highlight trailing whitespace
" match ErrorMsg '\s\+$'

" When opening a new split, it opens below & on the right
set splitbelow
set splitright

set showcmd " Show the current command on the lower right, like the  <leader> key

let mapleader = "\<Space>" " Set the <leader> to SPACE instead of \

if os == "Linux"
	set undofile " tell it to use an undo file
	set undodir=$HOME/.vim_undo/ " set a directory to store the undo history
endif

" ======== Buffers related options

" This allows buffers to be hidden if you've modified a buffer.
set hidden

" To open a new empty buffer instead of a tab
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>t :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>L :bprevious<CR>

" Move toe current buffer and move to the previous one
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

" Nerdtree shortcut
nmap <leader>k :NERDTreeToggle<cr>

" Reload the vimrc
nnoremap <leader>sr <ESC>:so $MYVIMRC<cr>

" vim-dispatch
nnoremap <F5> :Dispatch<cr>

" vim-fugitive
nnoremap <leader>gd :Gdiff<cr>
" close the left-most split (normally the diff file)
nnoremap <leader>gD <c-w>h<c-w>c
"
" un-map the Q key which opens the not used exec mode
map Q <Nop>

" ====== Grep & Ag commands

" search for the current word in the current directory
nnoremap <leader>J :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

if executable('ag')
	nnoremap \ :Ag <cword><SPACE>
	" search for the current word in the current file & open in the location-list
	nnoremap <leader>j :LAg <cword> % <cr>
	" map <silent><leader>j :Ag <cword><cr>
	" nmap <leader>j :grep <cword> %<cr>
endif

" ======== Set theme and colorscheme

if os == "win"
	set term=xterm
	let &t_AB="\e[48;5;%dm"
	let &t_AF="\e[38;5;%dm"
endif

" To be able to have 256 color sceme
set t_Co=256
let g:rehash256 = 1


syntax on
set background=dark

" colorscheme onedark
" colorscheme Tomorrow-Night-Eighties
" colorscheme Tomorrow-Night
colorscheme molokai

" Transparent background
" highlight Normal ctermbg=none
" highlight NonText ctermbg=none

filetype indent plugin on
