" .vimrc
" Jean-Philippe Goulet

" Inspired by : https://github.com/cabouffard/dotfiles

"{============ Get current OS ============

let os = ""
if has("win32") || has("win64")
	let os = "win"
else
    let os = substitute(system('uname'), "\n", "", "")
endif

"}{============ Plugins (with Vundle) ============

set nocompatible
filetype off

if os == "win"
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
    let path=$HOME.'/vimfiles/bundle'
    call vundle#begin(path)
else
    set rtp+=$HOME/.vim/bundle/Vundle.vim/
    call vundle#begin()
endif

"}{============ Add plugins here ============

" Vim config plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline' " The statusbar plugin
" Plugin 'mkitt/tabline.vim' " Better tab line (top)
Plugin 'scrooloose/nerdtree' " File explorer
Plugin 'ctrlpvim/ctrlp.vim' " fuzzy find a file in the current folder
Plugin 'tomtom/tcomment_vim' " shortcut to comment code
" Plugin 'easymotion/vim-easymotion' " movement that behaves like the chrome vim plugin (when F is clicked)

if os == "Linux"
    Plugin 'Valloric/YouCompleteMe' " auto-completion
    Plugin 'marijnh/tern_for_vim' " JS smarter autocompletion with YCM
endif

Plugin 'kien/rainbow_parentheses.vim'
Plugin 'tpope/vim-surround' " adds commands to modify surrounding characters
Plugin 'godlygeek/tabular' " toll to align text
Plugin 'Chiel92/vim-autoformat' " Auto-format code

" if ag (the_silver_searcher) is installed
if executable('ag')
    Plugin 'rking/ag.vim' " Better search tool than grep (requires AG package installed)
endif

" Plugin 'neilagabriel/vim-geeknote' " Integrate geeknote with vim (not working currently)
Plugin 'scrooloose/syntastic' " linting plugin. Uses external linters (ex. jshint) to work
Plugin 'drn/zoomwin-vim' " tool to enable focusing a single split
Plugin 'majutsushi/tagbar' " Browse a file tags (class layout etc..)
" Plugin 'tpope/vim-dispatch'

" Themes
Plugin 'flazz/vim-colorschemes' " Adds lots of themes
" Plugin 'joshdick/onedark.vim' " Atom's One dark theme
" Plugin 'joshdick/airline-onedark.vim' " Atom's One dark airline theme

" Language specific plugins
Plugin 'jelera/vim-javascript-syntax'
Plugin 'ntpeters/vim-better-whitespace' " Show & Remove Whitespaces command
" Plugin 'moll/vim-node' " Node.js
Plugin 'tmux-plugins/vim-tmux' " offers syntax highlight in tmux.conf file
Plugin 'heavenshell/vim-jsdoc' " helper to generate JSDoc comments
Plugin 'lervag/vimtex' " Latex
Plugin 'slim-template/vim-slim' " Syntax highlight for 'slim'

" Markdown specific
Plugin 'plasticboy/vim-markdown'
Plugin 'mzlogin/vim-markdown-toc' " generate a ToC in a single command
Plugin 'suan/vim-instant-markdown' " Markdown previewer (requires the npm package instant-markdown-d)

" GIT Related plugins
Plugin 'airblade/vim-gitgutter' " Shows git diff in the left panel
Plugin 'tpope/vim-fugitive' " Allows multiple GIT operation from inside vim
Plugin 'mattn/gist-vim' " Allow to post gist easily
Plugin 'mattn/webapi-vim' " WEBAPI used by gist-vim

" Ultisnips required plugins
Plugin 'sirver/ultisnips' " ultisnips engine
Plugin 'honza/vim-snippets' "ultisnips default snippets

call vundle#end()

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('bundle/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif

"}{============ Plugins configs ============

" vim-markdown
let g:vim_markdown_folding_disabled=1 " disable the collapse

" vim-instant-markdown
let g:instant_markdown_slow = 1 " Update the preview less often
let g:instant_markdown_autostart = 0 " Don't open a preview on file open, use :InstantMarkdownPreview instead

" vim-airline
set laststatus=2 "Is required or the status bar does not appear in the first vim split opened

let g:airline#extensions#tagbar#enabled = 0 "Disable tagbar integration (show current function) 
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers at the top
let g:airline#extensions#tabline#fnamemod = ':t' " Just show the filename (no path) in the tab
" let g:airline#extensions#tabline#buffer_idx_mode = 1 " Adds a tab number
" let g:airline_theme='onedark'
" let g:airline_powerline_fonts = 1 " Enable the patched fonts

" Enable Rainbow Parentheses at startup
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" vim-dispatch
" Set the compiler for vim-dispatch from the language
" autocmd FileType javascript let b:dispatch = 'node %'

" tagbar
nmap <F8> :TagbarToggle<CR>

" scrooloose/syntastic (linting)
let g:syntastic_check_on_open=1 "Run linting on file open on top of when the file is saved

" vim-autoformat
" let g:autoformat_autoindent = 0 " Don't defaults back to vim indent

" Use Ag (the_silver_surfer)
if executable('ag')

    " Use Ag instead of grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0

endif

" vim-jsdoc
let g:jsdoc_allow_input_prompt=1 " helper prompt to generate the JSDoc
let g:jsdoc_input_description=1 " include descritpion generation with the helper

" latex
let g:tex_flavor='latex' " to set the .tex files as latex and not plaintext

" YouCompletMe (YCM)
" Source : https://github.com/cabouffard/dotfiles/blob/master/.vimrc
let g:ycm_key_list_select_completion=["<tab>"]
let g:ycm_key_list_previous_completion=["<S-tab>"]

" UltiSnips
" Allows UltiSnips to co-exist with YCM
" Source : https://github.com/cabouffard/dotfiles/blob/master/.vimrc

let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsExpandTrigger="<nop>"
let g:ulti_expand_or_jump_res = 0

function! <SID>ExpandSnippetOrReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"

"}{============ Generic Settings ============

" Note : may cause lag when on?
set cursorline " Highlight the current line

" Tabulation related settings
set autoindent
set expandtab " use spaces instead of tab characters
set smarttab
set shiftwidth=4 " spaces for tabulations
set tabstop=4

" Language specific tab settings
au FileType ruby setl shiftwidth=2 tabstop=2

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

" Faster redraw, for diffs mostly which are really slow without this
set lazyredraw
set ttyfast

set mouse=a " enable the mouse (usefull to copy & paste out of vim)

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

"}{============ Buffers related options ============

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

"}{============ Custom Keybind mapping ============

" Easier to press ESC with 'jj'
:imap jj <Esc>

" Splits
" Moving around splits
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

" Move vertically by column
nnoremap j gj
nnoremap k gk

" Nerdtree shortcut
nmap <leader>k :NERDTreeToggle<cr>

" Reload the vimrc
nnoremap <leader>sr <ESC>:so $MYVIMRC<cr>

" vim-dispatch
nnoremap <F5> :Dispatch<cr>

" Search and replace word under cursor using F4
" Source : http://stackoverflow.com/a/5543793
nnoremap <F4> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

" vim-fugitive
nnoremap <leader>gd :Gdiff<cr>

" close the left-most split (normally the diff file)
nnoremap <leader>gD <c-w>h<c-w>c
"
" un-map the Q key which opens the not used exec mode
map Q <Nop>

" toggle pastemode easily
set pastetoggle=<F2>

"}{============ Grep & Ag commands ============

" search for the current word in the current directory
nnoremap <leader>J :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

if executable('ag')
    nnoremap \ :Ag <cword><SPACE>
    " search for the current word in the current file & open in the location-list
    nnoremap <leader>j :LAg <cword> % <cr>
    " map <silent><leader>j :Ag <cword><cr>
    " nmap <leader>j :grep <cword> %<cr>
endif

"}{============ Set theme and colorscheme ============

" Options for gVim gui
if has ("gui_running")
	set guioptions-=T " remove toolbar
	set guifont=Consolas:h10.5
	" set encoding=utf8
	" set termencoding=gbk
else
if os != "win"
	" To be able to have 256 color scheme
	set t_Co=256
	let g:rehash256 = 1
endif
	" if os == "win"
"		set term=xterm
"		let &t_AB="\e[48;5;%dm"
"		let &t_AF="\e[38;5;%dm"
	" endif
endif

" The patched font to add symbols to powerline
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10.5

syntax on
set background=dark

" colorscheme onedark
" colorscheme Tomorrow-Night-Eighties
" colorscheme Tomorrow-Night
" colorscheme molokai
colorscheme gruvbox

" Transparent background
" highlight Normal ctermbg=none
" highlight NonText ctermbg=none

filetype indent plugin on

"}=============================
