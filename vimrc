" .vimrc
" Jean-Philippe Goulet

" Inspired by : https://github.com/cabouffard/dotfiles
"               https://github.com/wincent/wincent/tree/master/roles/dotfiles/files/.vim

"============ Get current OS ============{{{

if has("win32") || has("win64")
    let os = "win"
else
    let os = substitute(system('uname'), "\n", "", "")
endif

" NOTE: Not yet tested on Windows
if os == 'win'
    let $VIMHOME = $VIM."/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif

" }}}
"============ Plugins (Vundle setup) ============{{{

set nocompatible
filetype off

set rtp+=$VIMHOME/bundle/Vundle.vim/

if os == "win"
    " NOTE: Not yet tested
    call vundle#begin($VIMHOME.'/bundle')
else
    call vundle#begin()
endif

" }}}
"============ Plugins (list) ============ {{{

" Vim config plugins
" ===========================
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'   " The statusbar plugin
Plugin 'vim-airline/vim-airline-themes' " Themes for vim-airline plugins
Plugin 'scrooloose/nerdtree' " File explorer
Plugin 'ctrlpvim/ctrlp.vim'  " fuzzy find a file in the current folder
Plugin 'tomtom/tcomment_vim' " shortcut to comment code
" Plugin 'easymotion/vim-easymotion'      " movement that behaves like the chrome vim plugin (when F is clicked)
" Plugin 'tpope/vim-eunuch' " add UNIX utilities functions
" Plugin 'terryma/vim-multiple-cursors' " Adds Sublime-like multiple cursors

if os == "Linux" && has('python')
    Plugin 'Valloric/YouCompleteMe' " auto-completion
    Plugin 'marijnh/tern_for_vim' " JS smarter autocompletion with YCM
endif

Plugin 'junegunn/rainbow_parentheses.vim'
Plugin 'tpope/vim-surround'             " adds commands to modify surrounding characters
Plugin 'tpope/vim-repeat'          " Enable using '.' for some other plugins (ex. surround.vim)
Plugin 'godlygeek/tabular'              " tool to align text
Plugin 'Chiel92/vim-autoformat'         " Auto-format code

" Run commands out of vim
" ========================
Plugin 'Shougo/vimproc.vim'             " Adds async capabilities (required by tsuquyomi for TypeScript)
Plugin 'tpope/vim-dispatch'
Plugin 'janko-m/vim-test'               " Test runner

" tmux plugins
" ========================
if executable('tmux')
    Plugin 'christoomey/vim-tmux-navigator' " Plugin to integrate tmux & vim together, to navigate easily
    Plugin 'benmills/vimux'                 " Run commands in TMUX from vim
endif

" if ag (the_silver_searcher) is installed
if executable('ag')
    Plugin 'rking/ag.vim' " Better search tool than grep (requires AG (the_silver_searcher) package installed)
endif

Plugin 'scrooloose/syntastic'      " linting plugin. Uses external linters (ex. jshint) to work
Plugin 'drn/zoomwin-vim'           " tool to enable focusing a single split
Plugin 'majutsushi/tagbar'         " Browse a file tags (class layout etc..)
Plugin 'jiangmiao/auto-pairs'      " Automatically add ending '', {}, (), ...
Plugin 'alvan/vim-closetag'        " Automatically close (x)html tags
Plugin 'AndrewRadev/splitjoin.vim' " Enable the gS (split) & gJ (join) smart commands
" Plugin 'ntpeters/vim-better-whitespace' " Show & Remove Whitespaces command
" Plugin 'metakirby5/codi.vim'       " Interactive scratch buffer

" Themes
" ===========================
Plugin 'flazz/vim-colorschemes'     " Adds lots of themes
Plugin 'morhetz/gruvbox'            " Adds the gruvbox theme
" Plugin 'joshdick/onedark.vim'     " Atom's One dark theme
" Plugin 'joshdick/airline-onedark.vim' " Atom's One dark airline theme
" Plugin 'chriskempson/base16-vim'
Plugin 'ryanoasis/vim-devicons'     " Adds icons to files names (NERDTree, Powerline, CtrlP, etc...)


" Language syntax support
" ===========================
Plugin 'othree/yajs.vim'                " javascript  syntax
" Plugin 'jelera/vim-javascript-syntax'
Plugin 'tmux-plugins/vim-tmux'          " tmux.conf   syntax
Plugin 'lervag/vimtex'                  " Latex       syntax
Plugin 'slim-template/vim-slim'         " slim        syntax
Plugin 'elixir-lang/vim-elixir'         " elixir      syntax
Plugin 'PotatoesMaster/i3-vim-syntax'   " i3 config   syntax
Plugin 'leafgarland/typescript-vim'     " typescript  syntax
Plugin 'elentok/plaintasks.vim'         " plaintasks  syntax and utils (for TODO list)
Plugin 'tpope/vim-git'                  " git         syntax

" Language specific plugins
" ===========================
Plugin 'moll/vim-node'                  " Custom Node.js functions, like 'gf' to go to a package source (when on a path)
Plugin 'heavenshell/vim-jsdoc'          " helper to generate JSDoc comments
Plugin 'mattn/emmet-vim'                " Add Emmet to vim to write faster HTML & CSS
Plugin 'Quramy/tsuquyomi'               " Add Typescript utilities

if has('python')
    Plugin 'OmniSharp/omnisharp-vim'        " Add omnisharp for good c# support
endif
Plugin 'ap/vim-css-color'               " Add colored background to CSS files color

" Text objects
" ===========================
Plugin 'michaeljsmith/vim-indent-object' " Add indent text object (using : ii, iI, ai, aI)

" Markdown specific
" ===========================
Plugin 'plasticboy/vim-markdown'
Plugin 'mzlogin/vim-markdown-toc'  " generate a ToC in a single command
Plugin 'suan/vim-instant-markdown' " Markdown previewer (requires the npm package instant-markdown-d)

" GIT Related plugins
" ===========================
Plugin 'airblade/vim-gitgutter' " Shows git diff in the left panel
Plugin 'tpope/vim-fugitive'     " Allows multiple GIT operation from inside vim
Plugin 'mattn/gist-vim'         " Allow to post gist easily
Plugin 'mattn/webapi-vim'       " WEBAPI used by gist-vim

" Ultisnips required plugins
" ===========================
if has('python')
    Plugin 'sirver/ultisnips'   " ultisnips engine
    Plugin 'honza/vim-snippets' " ultisnips default snippets
endif

call vundle#end()

" matchit.vim
" ==========================
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('bundle/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif

"}}}
"============ Plugins configs ============ {{{

augroup markdown
    autocmd!

    " vim-markdown
    " ==================
    autocmd FileType markdown let g:vim_markdown_folding_disabled = 1 " disable the collapse

    " vim-instant-markdown
    " ==================
    autocmd FileType markdown let g:instant_markdown_slow = 1 " Update the preview less often
    autocmd FileType markdown let g:instant_markdown_autostart = 0 " Don't open a preview on file open, use :InstantMarkdownPreview instead

augroup END

" vim-airline
" ==================

let g:airline#extensions#tagbar#enabled = 0      " Disable tagbar integration (show current function)
let g:airline#extensions#tabline#enabled = 1     " Enable the list of buffers at the top
let g:airline#extensions#tabline#fnamemod = ':t' " Just show the filename (no path) in the tab
let g:airline#extensions#tabline#buffer_idx_mode = 1 " Add a number to the tabs/buffer line (1-9), enables the <leader>NUMBER command

let g:airline#extensions#hunks#enabled = 0       " Remove the file diffs informations (+, -, ~)
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts = 1                " Enable the patched fonts

" vim-gitgutter
" ==================
" let g:gitgutter_enabled  = 0 " disable gitgutter by default
let g:gitgutter_eager    = 0 " Should improve speed when switching buffers
let g:gitgutter_map_keys = 0 " remove the default vim-gitgutter key mappings

" rainbow-parentheses
" ==================
augroup rainbow_parentheses
    autocmd!
    autocmd FileType javascript,cs RainbowParentheses " Enable Rainbow Parentheses at startup
augroup END

let g:rainbow#max_level = 16 " stop after X layers deep
let g:rainbow#pairs = [['(', ')'], ['{', '}']] " which characters to use as ( ) to check

" vim-dispatch
" ==================
augroup dispatch
    autocmd!

    " Set the compiler for vim-dispatch from the language
    autocmd FileType javascript let b:dispatch = 'node %'
    autocmd FileType typescript let b:dispatch = 'tsc *.ts'

augroup END

" Emmet vim
" ==================
let g:user_emmet_install_global = 0
" let g:user_emmet_leader_key='<C-Z>' " Replace the emmet leader key from Ctrl-Y

augroup emmet
    autocmd!

    " enable emmet ONLY for html & css
    autocmd FileType html,css EmmetInstall
augroup END


" Syntastic (linting)
" ==================
" Set syntastic to be passive by default
let g:syntastic_mode_map = { 'mode': 'passive'}
" let g:syntastic_mode_map = {
"             \'mode': 'passive',
"             \'active_filetypes': [
"             \    'python'
"             \],
"             \'passive_filetypes': [] }
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2 " Will not open automatically the loc list, but will close it when there are no more errors
let g:syntastic_check_on_open = 0 " Don't run linting on file open on top of when the file is saved

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_typescript_checkers = ['tsuquyomi'] " Use the tsuquyomi checker, instead of `tsc` checker
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']

" vim tsuquyomi options (typescript tools)
" ==================
let g:tsuquyomi_disable_quickfix = 1

" vim-autoformat
" ==================
" let g:autoformat_autoindent = 0 " Don't defaults back to vim indent

" Ag (the_silver_surfer)
" ==================
if executable('ag')

    " Use Ag instead of grep
    set grepprg=ag\ --nogroup\ --nocolor\ --column

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0

endif

" vim-jsdoc
" ==================
let g:jsdoc_allow_input_prompt=1 " helper prompt to generate the JSDoc
let g:jsdoc_input_description=1  " include descritpion generation with the helper

" vimtex
" ==================
let g:tex_flavor='latex'         " to set the .tex files as latex and not plaintext

" YouCompletMe (YCM)
" ==================
" Source: https://github.com/cabouffard/dotfiles/blob/master/.vimrc
let g:ycm_key_list_select_completion=["<tab>"]
let g:ycm_key_list_previous_completion=["<S-tab>"]

" UltiSnips
" ==================
" Allows UltiSnips to co-exist with YCM
" Source: https://github.com/cabouffard/dotfiles/blob/master/.vimrc

let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
" let g:UltiSnipsExpandTrigger="<tab>"
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

" OmniSharp vim
" ==================
" Source: https://github.com/OmniSharp/omnisharp-vim#example-vimrc
let g:OmniSharp_timeout = 5000 " Timeout in ms to wait for a response from the server
" set cmdheight=2 " Remove 'Press Enter to continue' message when type information is longer than one line.

augroup omnisharp_settings
    autocmd!

    " automatic syntax check on events
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    " show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

augroup END

" vim-test
" ==================
" make test commands execute using dispatch.vim
let test#strategy = "dispatch"

" vim-colorschemes
" =================
" Source: https://github.com/altercation/vim-colors-solarized
" Fix the solarized theme
" let g:solarized_contrast="high" " Set a 'high|low|normal' contrast between the colors
" let g:solarized_termcolors=256 " Set the colors from 16 to 256 for the Solarized theme

" NERDTree
" ================
let NERDTreeIgnore = ['\.pyc$', '__pycache__'] " files & folders to ignore/hide

"}}}
"============ Generic Settings ============ {{{

" Basic settings
" =================
set hidden       " This allows buffers to be hidden if you've modified a buffer.
set number
" set relativenumber
set scrolloff=10 " keeps lines over or under the cursor at all time
set incsearch    " start searching before clicking ENTER

set cursorline   " Highlight the current line (may cause lag when on?)
set showcmd      " Show the current command on the lower right, like the  <leader> key

set laststatus=2 " always shows the status line

if has('wildmenu')
    set wildmenu  " better autocompletion for : menu, adds a list of possible options on <TAB> press
endif

let mapleader = "\<Space>"  " Set the <leader> to SPACE instead of \

" Case related settings
" ==================
set ignorecase   " ignore case by default
set infercase
set smartcase    " will go case-sensitive if there is caps

" Source : https://github.com/spf13/spf13-vim/blob/3.0/.vimrc#L107-L113
if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else                   " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

" Optimization
" =================
" Faster redraw, for diffs & macros mostly which can be slow without this
set lazyredraw
set ttyfast

" Reduce the delay on key press to wait for other commands with the same key
" (ex. <ESC> vs <ESC>a, it would wait this amount of time to check if we click
" 'a' after the ESC.
" Source: https://www.johnhawthorn.com/2012/09/vi-escape-delays/
set timeoutlen=400
set ttimeoutlen=0

" Look at 'fo-table' in the help for options
set formatoptions+=n       " Automatically recognize lists for auto-indent
set formatoptions+=j       " Remove comments leader when merging with J

if has('windows')
    set splitbelow " Open a new split below
endif

if has('vertsplit')
    set splitright " Open a new split on the right
endif

set mouse=a " enable the mouse (useful to copy & paste out of vim)

set encoding=utf8 ""

" Undo files
" Source: https://www.youtube.com/watch?v=PYketjc9aus (wincent videos)
" Source: https://github.com/wincent/wincent/blob/7f3f2717dad2c9bb7c14ad568d5b68babc2bf1a3/roles/dotfiles/files/.vim/plugin/settings.vim
" =================
if has('persistent_undo')
    if exists('$SUDO_USER')
        set noundofile " If current user is root, no undofile
    else
        set undodir=$VIMHOME/tmp/undo/ " set a directory to store the undo history
        set undodir+=$VIMHOME/.vim_undo " set a backup directory if the other does not exist
        set undodir+=.
        set undofile    " tell it to use an undo file
    endif
endif

" Swap files
" Source: https://www.youtube.com/watch?v=PYketjc9aus (wincent videos)
" =================
if exists('$SUDO_USER')
    set noswapfile " If current user is root, no swapfile
else
    " NOTE : the second / is important to use the complete path for the swap
    " file name, so no collision
    set directory=$VIMHOME/tmp/swap// " set a directory to store the swap file
    set directory+=. " use the current location as backup if the other does not exist
endif

" viminfo file
" Source: https://www.youtube.com/watch?v=BvjcW885uHw (wincent videos)
" =================
" This file saves informations about the last session
" like the commands & etc.. Don't save it as root
if has('viminfo')
    if exists('$SUDO_USER')
        set viminfo=
    else
        " Cannot set multiple path as backup paths, so must check by hand
        if isdirectory($VIMHOME.'/tmp/viminfo')
            set viminfo+=n$VIMHOME/tmp/viminfo
        else
            " is already the default, but just in case
            set viminfo+=n$HOME/.viminfo
        endif
    endif
endif

" Folding
" =================
if has('folding')
    if has('windows')
        " requires both folding & windows setting enabled
        " Change the vertical character used to in between splits
        set fillchars=vert:┃            "BOX DRAWINGS HEAVY VERTICAL' (U+2503, UTF-8: E2 94 83)
    endif

    set foldmethod=indent " folds by following the language syntax
    set foldlevel=1
    set nofoldenable " disable the folds from the start

    augroup fold_settings_filetype
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
        autocmd FileType cs setlocal foldmethod=syntax
        " NOTE : yajs + foldmethod=syntax cause HUGE lags on opening a big file
        " (10-15 sec loading times)
        autocmd FileType javascript setlocal foldmethod=indent
    augroup END
endif

" Replace whitespace characters with visible ones
" ===============================================
set list                              " show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
" + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
" set listchars+=extends:»            " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
" set listchars+=precedes:«           " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)

if has('linebreak')
    " The symbol to show in front of a wrapped line
    let &showbreak='⤷ '               " ARROW POINTING DOWNWARDS THEN CRUGING RIGHTWARDS (U+2937, UTF-8: E2 A4 B7)
endif

if has('virtualedit')
    set virtualedit=block       " Allow cursor to move where there is nothing in visualblock mode
endif

" Tabulation related settings
" ==================
set autoindent
set expandtab    " use spaces instead of tab characters
set smarttab
set shiftwidth=4 " spaces for tabulations
set tabstop=4
set fileformat=unix

augroup tabs_settings
    autocmd!
    autocmd FileType ruby       setl shiftwidth=2 tabstop=2
    autocmd FileType javascript setl shiftwidth=4 tabstop=4
    autocmd FileType python     setl shiftwidth=4 tabstop=4 textwidth=79
augroup END

" Misc
" =================

augroup vim_resize
    autocmd!
    " Source: https://github.com/cabouffard/dotfiles/blob/master/.vimrc
    autocmd VimResized * wincmd =  " Automaticaly resize the panes on resize (calls 'CTRL + W + =')
augroup END

augroup autocompletion
    autocmd!
    " Automatically closes the scratchpad with the function info when the function is selected
    autocmd CompleteDone * pclose
augroup END

" }}}
"============ Keybind mappings ============ {{{

" un-map the Q key which opens the not used exec mode
map Q <Nop>
" un-map the K key, which open a man page for the current word
map K <Nop>

set pastetoggle=<F2> " toggle pastemode easily

" Insert mode {{{
" ----------------

" Easier to press ESC with 'jj'
imap jj <Esc>

" }}}

" Normal mode binds {{{
" ----------------

" TODO : Move this into a REAL init.nvim instead
if has('nvim')
    " Fixes the nvim burlfeature that sees <C-h> as a <BS>
    " Note : it is a terminal feature (backspace when you press <C-h>),
    " but in vim it's annoying
    nmap <BS> <C-h>
endif

" Splits
" ==================
" Moving around splits
noremap <C-j> <C-W><C-J>
noremap <C-k> <C-W><C-K>
noremap <C-l> <C-W><C-L>
noremap <C-h> <C-W><C-H>

" Joins the current and previous line
nmap <C-J> kJ

" Now Y copies until the end of line. To have consistant behavior with D & C.
nnoremap Y y$

" Split at the cursor location, the opposite of 'J'
" source: https://www.reddit.com/r/vim/comments/4izk0n/vi_blunders/d32gw7y
nmap S i<CR><Esc>d^==kg_lD

" Move vertically by column
nnoremap j gj
nnoremap k gk

" goes back to the previous cursor positions
nnoremap gh g;
" goes forward to the next cursor positions
nnoremap gl g,

" open the last buffer
nnoremap <leader><leader> <C-^>

" Reload the vimrc
nnoremap <leader>sr <ESC>:so $MYVIMRC<cr>

" Inspired from https://github.com/tpope/vim-unimpaired
" quickfix list mappings
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>

" Inspired from https://github.com/tpope/vim-unimpaired
" location list mappings
nnoremap ]l :lnext<cr>
nnoremap [l :lprevious<cr>

" Easier to access start & end of line
noremap H ^
noremap L $


" Search and replace word under cursor using F4
" Source: http://stackoverflow.com/a/5543793
" nnoremap <F4> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

" Search and replace word under cursor
" Source: https://github.com/cabouffard/dotfiles/blob/master/.vimrc
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

" search for the current word in the current directory
" nnoremap <leader>J :lgrep! "\b<C-R><C-W>\b"<CR>:cw<CR>

nnoremap <leader>w :w<CR>

" Allow faster access to window commands (ex. ss => split, sv => vsplit, sq =>
" close split ....)
nnoremap s <C-W>

" toggle highlight search
nmap <F4> :set hlsearch!<cr>

" To open a new empty buffer instead of a tab
nnoremap <leader>t :enew<cr>

" Move to the next/previous buffer
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nnoremap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nnoremap <leader>bl :ls<CR>

" Toggle between the last & current buffer
nnoremap <leader>q :b#<cr>

" Toggle splits
nnoremap <leader>z za

" }}}

" Visual mode binds {{{
" ----------------

" Keybind to sort the words in the current Visual selection
vnoremap <F3> d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>

" keep the selection after indent, so it is easily repeatable
vnoremap < <gv
vnoremap > >gv

" }}}

" Command mode binds {{{

" Move in command mode (start & end of line)
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" }}}


" }}}
"============ Keybind mappings (Plugins) ============ {{{

" Nerdtree
" ==================
nnoremap <leader>k :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFind<cr>

" tagbar
" ==================
nmap <F8> :TagbarToggle<CR>

" vim-dispatch
" ==================
nnoremap <F5> :Dispatch<cr>

" vimux
" ==================

augroup vimux
    autocmd!
    " Run the current file with pytest
    autocmd FileType python     map <Leader>vt :call VimuxRunCommand("clear; pytest " . bufname("%"))<CR>
    autocmd FileType javascript map <Leader>vt :call VimuxRunCommand("clear; npm test")<CR>

augroup END

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>
" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

" vim-tmux-navigator
" ==================

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" airline
" ==================

" Select tab/buffers
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab2
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" vim-autoformat
" ==================
nnoremap <leader>af :Autoformat<cr>

" syntastic
" ==================
nnoremap <leader>c :SyntasticCheck<cr>

" CtrlP
" ==================
nnoremap <C-b> :CtrlPBuffer<CR>

" vim-fugitive
" ==================
nnoremap <leader>gd :Gvdiff<cr>
" close the left-most split (normally the diff file)
nnoremap <leader>gD <c-w>h<c-w>c
nnoremap <leader>gs :Gstatus<cr>

" Ag.vim
" ==================
if executable('ag')
    nnoremap \ :Ag <cword><SPACE>
    " search for the current word in the current file
    nnoremap <leader>j :Ag <cword> % <cr>
    " search for the current word in the project
    nnoremap <leader>J :Ag <cword><cr>
endif

" YouCompleteMe
" =================
" nmap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" tern_for_vim
" =================

" Tern is only installed on linux
if os == "Linux"
    augroup tern_mappings
        autocmd!

        autocmd FileType javascript nnoremap gd :TernDef<cr>
    augroup END
endif

" OmniSharp
" ==================
" Source: https://github.com/OmniSharp/omnisharp-vim#example-vimrc
augroup omnisharp_mappings
    autocmd!

    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <F12> :OmniSharpGotoDefinition<cr>

    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>

    " finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>

    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    " "navigate up by method/property/field
    " autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    " "navigate down by method/property/field
    " autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

    " replace AutoFormat command with the OmniSharp one in C# files
    autocmd FileType cs nnoremap <leader>af :OmniSharpCodeFormat<cr>

    autocmd FileType cs nnoremap <leader>th :OmniSharpHighlightTypes<cr>
    " Contextual code actions (requires CtrlP or unite.vim)
    autocmd FileType cs nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
    " Run code actions with text selected in visual mode to extract method
    autocmd FileType cs vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

    " rename with dialog
    autocmd FileType cs noremap <leader>nm :OmniSharpRename<cr>
    autocmd FileType cs noremap <F2> :OmniSharpRename<cr>

    " rename without dialog - with cursor on the symbol to rename... ':Rename newname'
    autocmd FileType cs command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

augroup END

" }}}
"============ Theme and colorscheme ============ {{{

" Options for gVim gui
if has ("gui_running")
    set guioptions-=T " remove toolbar
    set guifont=Consolas:h10
    " set termencoding=gbk
else
    if os != "win"
        " To be able to have 256 color scheme
        set t_Co=256
        let g:rehash256 = 1
    endif
    " if os == "win"
    "       set term=xterm
    "       let &t_AB="\e[48;5;%dm"
    "       let &t_AF="\e[38;5;%dm"
    " endif
endif


" The patched font to add symbols to powerline
set guifont=Hack\ 10.5


" Disable the transparent background in tmux
if !has("nvim")
    set term=screen-256color
endif

syntax on
set background=dark

let theme_name = "gruvbox"
" silent! colorscheme onedark
" silent! colorscheme Tomorrow-Night-Eighties
" silent! colorscheme Tomorrow-Night
" silent! colorscheme molokai
" silent! colorscheme solarized
" silent! colorscheme badwolf
silent! execute "colorscheme ".theme_name



" Transparent background fix (don't add a background to text)
" highlight Normal ctermbg=none
" highlight NonText ctermbg=none

filetype indent plugin on

"============================= }}}
