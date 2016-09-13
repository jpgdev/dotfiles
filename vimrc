" .vimrc
" Jean-Philippe Goulet

" Inspired by : https://github.com/cabouffard/dotfiles

"============ Get current OS ============{{{

if has("win32") || has("win64")
    let os = "win"
else
    let os = substitute(system('uname'), "\n", "", "")
endif

" }}}
"============ Plugins (Vundle setup) ============{{{

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

" }}}
"============ Plugins (list) ============ {{{

" Vim config plugins
" ===========================
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'   " The statusbar plugin
Plugin 'vim-airline/vim-airline-themes' " Themes for vim-airline plugins
" Plugin 'mkitt/tabline.vim' " Better tab line (top)
Plugin 'scrooloose/nerdtree' " File explorer
Plugin 'ctrlpvim/ctrlp.vim'  " fuzzy find a file in the current folder
Plugin 'tomtom/tcomment_vim' " shortcut to comment code
" Plugin 'easymotion/vim-easymotion'      " movement that behaves like the chrome vim plugin (when F is clicked)
Plugin 'tpope/vim-eunuch' " add UNIX utilities functions

if os == "Linux"
    Plugin 'Valloric/YouCompleteMe' " auto-completion
    Plugin 'marijnh/tern_for_vim' " JS smarter autocompletion with YCM
endif

Plugin 'junegunn/rainbow_parentheses.vim'
Plugin 'tpope/vim-surround'             " adds commands to modify surrounding characters
Plugin 'godlygeek/tabular'              " tool to align text
Plugin 'Chiel92/vim-autoformat'         " Auto-format code
Plugin 'christoomey/vim-tmux-navigator' " Plugin to integrate tmux & vim together, to navigate easily
Plugin 'Shougo/vimproc.vim'             " Adds async capabilities (required by tsuquyomi for TypeScript)
Plugin 'janko-m/vim-test'               " Test runner

" if ag (the_silver_searcher) is installed
if executable('ag')
    Plugin 'rking/ag.vim' " Better search tool than grep (requires AG (the_silver_searcher) package installed)
endif

" Plugin 'neilagabriel/vim-geeknote'                         " Integrate geeknote with vim (not working currently)
Plugin 'scrooloose/syntastic'      " linting plugin. Uses external linters (ex. jshint) to work
Plugin 'drn/zoomwin-vim'           " tool to enable focusing a single split
Plugin 'majutsushi/tagbar'         " Browse a file tags (class layout etc..)
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-repeat'          " Enable using '.' for some other plugins (ex. surround.vim)
Plugin 'jiangmiao/auto-pairs'      " Automatically add ending '', {}, (), ...
Plugin 'alvan/vim-closetag'        " Automatically close (x)html tags
Plugin 'AndrewRadev/splitjoin.vim' " Enable the gS (split) & gJ (join) smart commands

" Themes
" ===========================
" Plugin 'morhetz/gruvbox' " Adds the gruvbox theme
Plugin 'flazz/vim-colorschemes'     " Adds lots of themes
" Plugin 'joshdick/onedark.vim'     " Atom's One dark theme
" Plugin 'joshdick/airline-onedark.vim' " Atom's One dark airline theme
" Plugin 'chriskempson/base16-vim'
" Plugin 'ryanoasis/vim-devicons'   " Adds icons to files names (NERDTree, Powerline, CtrlP, etc...)

" Language specific plugins
" ===========================
Plugin 'othree/yajs.vim' " javascript syntax
" Plugin 'jelera/vim-javascript-syntax'
Plugin 'ntpeters/vim-better-whitespace' " Show & Remove Whitespaces command
Plugin 'moll/vim-node'                  " Custom Node.js functions, like 'gf' to go to a package source (when on a path)
Plugin 'tmux-plugins/vim-tmux'          " offers syntax highlight in tmux.conf file
Plugin 'heavenshell/vim-jsdoc'          " helper to generate JSDoc comments
Plugin 'lervag/vimtex'                  " Latex
Plugin 'slim-template/vim-slim'         " Syntax highlight for 'slim'
Plugin 'ap/vim-css-color'               " Add colored background to CSS files colors
Plugin 'elixir-lang/vim-elixir'         " Add support for elixir language
Plugin 'leafgarland/typescript-vim'     " Add typescript filetype support
Plugin 'Quramy/tsuquyomi'               " Add Typescript utilities
Plugin 'mattn/emmet-vim'                " Add Emmet to vim to write faster HTML & CSS
Plugin 'OmniSharp/omnisharp-vim'        " Add omnisharp for good c# support
Plugin 'elentok/plaintasks.vim'         " Add plaintasks filetype and support (for TODO list)
Plugin 'PotatoesMaster/i3-vim-syntax'   " Syntax highlight for i3 config file

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
Plugin 'sirver/ultisnips' " ultisnips engine
Plugin 'honza/vim-snippets' " ultisnips default snippets

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
set laststatus=2 "Is required or the status bar does not appear in the first vim split opened

let g:airline#extensions#tagbar#enabled = 0      " Disable tagbar integration (show current function)
let g:airline#extensions#tabline#enabled = 1     " Enable the list of buffers at the top
let g:airline#extensions#tabline#fnamemod = ':t' " Just show the filename (no path) in the tab
" let g:airline#extensions#tabline#buffer_idx_mode = 1 " Adds a tab number
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

augroup emmet
    autocmd!

    " enable emmet ONLY for html & css
    autocmd FileType html,css EmmetInstall
augroup END

" tagbar
" ==================
nmap <F8> :TagbarToggle<CR>

" Syntastic (linting)
" ==================
" Set syntastic to be passive by default
let g:syntastic_mode_map = {
            \'mode': 'passive',
            \'active_filetypes': [
            \    'python'
            \],
            \'passive_filetypes': [] }
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1 "Run linting on file open on top of when the file is saved

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
    set grepprg=ag\ --nogroup\ --nocolor

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
" let g:solarized_contrast="high" " Set a 'high|low|normal' contrast between the colors
" let g:solarized_termcolors=256 " Set the colors from 16 to 256 for the Solarized theme

" NERDTree
" ================
let NERDTreeIgnore = ['\.pyc$', '__pycache__'] " files & folders to ignore/hide

"}}}
"============ Generic Settings ============ {{{

" Note : may cause lag when on?
set cursorline   " Highlight the current line

augroup vim_resize
    autocmd!

    " Source: https://github.com/cabouffard/dotfiles/blob/master/.vimrc
    autocmd VimResized * wincmd =  " Automaticaly resize the panes on resize (calls 'CTRL + W + =')

augroup END

" Tabulation related settings
" ==================
set autoindent
set expandtab    " use spaces instead of tab characters
set smarttab
set shiftwidth=4 " spaces for tabulations
set tabstop=4
set fileformat=unix

" Language specific tab settings
" ==================
augroup tabs_settings
    autocmd!
    autocmd FileType ruby       setl shiftwidth=2 tabstop=2
    autocmd FileType javascript setl shiftwidth=4 tabstop=4
    autocmd FileType python     setl shiftwidth=4 tabstop=4 textwidth=79
augroup END

augroup fold_methods
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup autocompletion
    autocmd!
    " Automatically closes the scratchpad with the function info when the function is selected
    autocmd CompleteDone * pclose
augroup END

" Case related settings
" ==================
set ignorecase   " ignore case by default
set infercase
set smartcase    " will go case-sensitive if there is caps

set scrolloff=10 " keeps lines over or under the cursor at all time

" set backspace=indent,eol,start
set incsearch " start searching before clicking ENTER
set wildmenu  " better autocompletion for : menu, adds a list of possible options on <TAB> press

" Source: http://stackoverflow.com/a/30691754/4995329
set clipboard^=unnamed,unnamedplus " link the vim clipboard with the OS (ex. "+yy => copies the current line)
" set colorcolumn=80 " Adds a column at 80 characters

" Line numbering
" ==================
set number
" set relativenumber

" Faster redraw, for diffs mostly which are really slow without this
set lazyredraw
set ttyfast

" Reduce the delay on key press to wait for other commands with the same key
" (ex. <ESC> vs <ESC>a, it would wait this amount of time to check if we click
" 'a' after the ESC.
" Source: https://www.johnhawthorn.com/2012/09/vi-escape-delays/
set timeoutlen=400
set ttimeoutlen=0

set mouse=a " enable the mouse (useful to copy & paste out of vim)

" When opening a new split, it opens below & on the right
set splitbelow
set splitright

" This allows buffers to be hidden if you've modified a buffer.
set hidden

" Show the current command on the lower right, like the  <leader> key
set showcmd

let mapleader = "\<Space>"  " Set the <leader> to SPACE instead of \

if os == "Linux"
    set undofile                 " tell it to use an undo file
    set undodir=$HOME/.vim_undo/ " set a directory to store the undo history
endif

" NOTE : yajs + foldmethod=syntax cause HUGE lags on opening a big file
" (10-15 sec loading times)
set foldmethod=indent " folds by following the language syntax
set foldlevel=1
set nofoldenable " disable the folds from the start

" }}}
"============ Keybind mappings ============ {{{

" Easier to press ESC with 'jj'
imap jj <Esc>

" Joins the current and previous line
nmap K kJ

" Split at the cursor location, the opposite of 'J'
" source: https://www.reddit.com/r/vim/comments/4izk0n/vi_blunders/d32gw7y
nmap S i<CR><Esc>d^==kg_lD

" Splits
" ==================
" Moving around splits
noremap <C-j> <C-W><C-J>
noremap <C-k> <C-W><C-K>
noremap <C-l> <C-W><C-L>
noremap <C-h> <C-W><C-H>

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

" keep the selection after indent, so it is easily repeatable
vnoremap < <gv
vnoremap > >gv

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

" un-map the Q key which opens the not used exec mode
map Q <Nop>

nnoremap <leader>w :w<CR>

" Allow faster access to window commands (ex. ss => split, sv => vsplit, sq =>
" close split ....)
nnoremap s <C-W>

" Reopen the last buffer
" Source: https://github.com/cabouffard/dotfiles/blob/master/.vimrc
nmap <Leader>e :e#<CR>

" toggle pastemode easily
set pastetoggle=<F2>

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

" Keybind to sort the words in the current Visual selection
vnoremap <F3> d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>

" }}}
"============ Keybind mappings (Plugins) ============ {{{

" Nerdtree
" ==================
nnoremap <leader>k :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFind<cr>

" vim-dispatch
" ==================
nnoremap <F5> :Dispatch<cr>

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

set encoding=utf8

" The patched font to add symbols to powerline
set guifont=Hack\ 10.5

syntax on
set background=dark

" colorscheme onedark
" colorscheme Tomorrow-Night-Eighties
" colorscheme Tomorrow-Night
" colorscheme molokai
" colorscheme gruvbox
" colorscheme solarized
colorscheme badwolf

" Disable the transparent background in tmux
set term=screen-256color

" Transparent background fix (don't add a background to text)
highlight Normal ctermbg=none
highlight NonText ctermbg=none

filetype indent plugin on

"============================= }}}
