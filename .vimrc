" ----------------------------------------------------------------------------
" VIMRC
" ----------------------------------------------------------------------------

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"" Use comma instead of backslash
let mapleader=","
let maplocalleader=","

"" Load Pathogen
call pathogen#infect()

"" MacVim settings
if has("gui_macvim")
  let macvim_skip_cmd_opt_movement=1
  set fuoptions=maxvert,maxhorz
endif

"" commandline
if has('cmdline_info')
   set ruler                   " show the ruler
   set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
   set showcmd                 " show partial commands in status line
endif

"" gui
if has("gui_running")
  set guioptions-=T
  set guioptions-=m
  set guioptions-=L
  set guifont=Anonymous\ Pro:h14
  set background=dark
  colorscheme solarized
end

" ----------------------------------------------------------------------------
" SETTINGS
" ----------------------------------------------------------------------------

syntax on

set expandtab               " expand tabs to spaces
set tabstop=4               " 4 Spaces for tabs
set shiftwidth=4            " number of spaces use for each step of indent
set softtabstop=4           " backspace removes tabs
set autoindent              " copy indent from current line when starting a new line
set visualbell              " don't beep
set autoread                " automatically re-read changed files
set showmatch               " briefly jump to a matching bracket
set incsearch               " jump to searchterm
set number                  " show line numbers
set numberwidth=1           " width for numbers
set antialias               " font smoothing
set foldmethod=manual       " manually fold lines
set nowrap                  " no line wrapping
set showtabline=2           " Always show tab bar
set scrolloff=3             " Keep more context when scrolling off the end of a buffer
set wildmenu                " Make tab completion for files/buffers act like bash
set wildmode=longest,list   " use emacs-style tab completion when selecting files, etc
set hlsearch                " highlight search term
"set ignorecase              " case sensitive search
set smartcase               " only case sensitiv if they contain upper case characters
set mousehide               " Hide the mouse pointer while typing
set list                    " show white space characters and tabs
set listchars=trail:·,extends:>,precedes:<,tab:»·
set autochdir               " Auto change working directory
set ofu=syntaxcomplete#Complete
set formatoptions=cq textwidth=72 foldignore= wildignore+=*.py[co " Wrap at 72 chars for comments.

" Highlight end of line whitespace.
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" ----------------------------------------------------------------------------
" MAPPINGS
" ----------------------------------------------------------------------------
inoremap <C-space> <c-x><c-p>

" write the file
nmap <f2> :w <cr>

" call make
nmap <c-f2> :make % <cr>

" Close the Buffer
nmap <f4> :bdel <cr>

" Previous Buffer
nmap <f5> :bp <cr>

" Next Buffer
nmap <f6> :bn <cr>

" move in split windows with ctrl key
nmap <c-up> <up>
nmap <c-down> <down>
nmap <c-right> <right>
nmap <c-left> <left>
nmap <c-s-up> <up> _
nmap <c-s-down> <down> _

" move in split windows for mac with apple key
nmap <D-Up> <Up>
nmap <D-Down> <Down>
nmap <D-Right> <Right>
nmap <D-Left> <Left>
nmap <D-S-Up> <Up>_
nmap <D-S-Down> <Down>_

" go to next / previous tab
map  <d-left>  :tabp <cr>
imap <d-left>  <esc> :tabp <cr> i
map  <d-right> :tabn <cr>
imap <d-right> <esc> :tabn <cr> i

" clear the search buffer when hitting return
:nnoremap <cr> :nohlsearch<cr>/<bs>

" find whitespace
map <leader>ws :%s/ *$//g<cr><c-o><cr>

" highligths all from import statements
com! FindLastImport :execute'normal G<cr>' | :execute':normal ?^\(from\|import\)\><cr>'
map <leader>fi :FindLastImport<cr>

" Map ,e to open files in the same directory as the current file
map <leader>e :e <C-R>=expand("%:h")<cr>/

" ----------------------------------------------------------------------------
" BACKUP
" ----------------------------------------------------------------------------

" backup, swap, views
set backup                       " backups are nice ...
set backupdir=$HOME/.vimbackup// " but not when they clog .
"set directory=$HOME/.vimswap//   " Same for swap files
set viewdir=$HOME/.vimviews//    " same for view files

"" Creating directories if they don't exist
silent execute '!mkdir -p $HOME/.vimbackup'
"silent execute '!mkdir -p $HOME/.vimswap'
silent execute '!mkdir -p $HOME/.vimviews'
au BufWinLeave * silent! mkview   " make vim save view (state) (folds, cursor, etc)
au BufWinEnter * silent! loadview " make vim load view (state) (folds, cursor, etc)

" ----------------------------------------------------------------------------
" PLUGIN CONFIGS
" ----------------------------------------------------------------------------

"" pyflakes plugin
"" let g:pyflakes_use_quickfix = 0

"" vimgrep plugin
let Grep_Xargs_Options='-0'
let Grep_Skip_Files='*~ *,v s.*,.pyc,.pyo,.svn'
let Grep_Skip_Dirs='RCS CVS SCCS .svn .git'
nnoremap <silent> <f3> :Grep <cr>
nnoremap <silent> <s-f3> :Rgrep <cr>

"" nerdtree plugin
map <silent><c-tab> :NERDTreeToggle <cr>
map <silent><c-f> :NERDTreeFind <cr>
let g:NERDTreeMapActivateNode="<cr>"
let g:NERDTreeMapOpenSplit="<s-cr>"
let g:NERDTreeMapOpenVSplit="<c-cr>"
let g:NERDTreeIgnore=['\.pyc$', '\.pyo$', '\~$', '\$py.class']
let g:NERDTreeChDirMode=2

"" supertab plugin
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabDefaultCompletionType = "<c-x><c-p>"

"" python syntax file
let python_highlight_all=1
let python_slow_sync=1

"" vcscommand plugin
let g:VCSCommandMapPrefix='<Leader>x'

"" EasyGrep
let g:EasyGrepRecursive=1

"" pylint plugin
let g:pylint_onwrite = 0
let g:pylint_cwindow = 1
let g:pylint_show_rate = 1


"-----------------------------------------------------------------------------
" Omni Completion
"-----------------------------------------------------------------------------
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
