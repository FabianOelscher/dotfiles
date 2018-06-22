let g:mapleader = ','
filetype indent plugin on
syntax on
set hidden
set wildmenu
set showcmd
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Always display the status line, even if only one window is displayed
set laststatus=2

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

"pressing enter in normal mode will add new line
nmap <CR> i<CR><Esc>kE
" turn off search highlight
nnoremap <leader><leader> :nohlsearch<CR>

set nowrap

" set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $
" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

" jk is escape
inoremap jk <ESC>

" save session
nnoremap <leader>s :mksession<CR>

"Plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
"neet tmux navi
Plug 'christoomey/vim-tmux-navigator'
"fuzzyfinder find files
Plug 'kien/ctrlp.vim'
"find file that contains text
Plug 'mileszs/ack.vim'
"statusbar
Plug 'bling/vim-airline'

"autoclose () '' etc.
Plug 'raimondi/delimitmate'
"scrolling
Plug 'terryma/vim-smooth-scroll'
"show indentation
Plug 'nathanaelkane/vim-indent-guides' "toogle with <leader>ig
"add snippets & ultisnips
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

Plug 'roxma/vim-paste-easy'

"repeat even more with .
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary' "gcc comment out line, gc comment out motion
"Tagfiles
Plug 'ludovicchabant/vim-gutentags'
"language
"js
"syntax-highlight
Plug 'jelera/vim-javascript-syntax'
"third-party
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'mxw/vim-jsx'
"typescript
Plug 'leafgarland/typescript-vim'
"linter
Plug 'w0rp/ale'
"autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
call plug#end()

"Plugin-Shortcuts

map <leader>n :NERDTreeToggle<CR>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<leader><tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
"javascript-libraries-syntax
let g:used_javascript_libs = 'jquery,angularjs,angularui,angularuirouter,react'

" Enable completion where available.
let g:ale_completion_enabled = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" disable autocomplete by default
let b:deoplete_disable_auto_complete=1 
let g:deoplete_disable_auto_complete=1

let g:deoplete#omni#input_patterns = {}
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" deoplete ternjs
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#guess = 0
let g:deoplete#sources#ternjs#case_insensitive = 1
"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx']

" Use tern_for_vim.
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif
" deoplete tab-complete
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
"scrolling
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 18, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 18, 1)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 18, 2)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 18, 2)<CR>
