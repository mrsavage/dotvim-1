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

"" statusline
if has('statusline')
  set laststatus=2            " show statusline only if there are > 1 windows
  set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
endif

"" gui
if has("gui_running")
  set guioptions-=T
  set guioptions-=m
  set guioptions-=L
  set guifont=SourceCodePro-Regular:h15
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
let g:pyflakes_use_quickfix = 0

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


"-----------------------------------------------------------------------------
" NerdTree
"-----------------------------------------------------------------------------
"Show hidden files in NerdTree
let NERDTreeShowHidden=1

" ----------------------------------------------------------------------------
" AUTOCOMMANDS
" ----------------------------------------------------------------------------

if has("autocmd") && !exists("autocommands_loaded")
  let autocommands_loaded=1

  " Enable file type detection.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx

  " Remove ALL autocommands for the current group.
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78
  "
  " Get this plugin from http://www.vim.org/scripts/script.php?script_id=1112
  " " Pressing "K" takes you to the documentation for the word under the cursor.
  " autocmd filetype python source ~/.vim/pydoc.vim

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |exe "normal g`\"" |endif

  autocmd FileType javascript set ts=4 sw=4
  autocmd FileType html set ts=2 sw=2 expandtab
  autocmd FileType CHANGELOG set ts=4 sw=4 expandtab
  autocmd FileType cfg set ts=4 sw=4 expandtab
  autocmd FileType python compiler pylint

  " add cusstom commentstring for nginx
  autocmd FileType nginx let &l:commentstring='#%s'

  autocmd BufNewFile,BufRead *.js setfiletype javascript
  autocmd BufNewFile,BufRead *.dtml setfiletype css
  autocmd BufNewFile,BufRead *.pt setfiletype html
  autocmd BufNewFile,BufRead *.zcml setfiletype xml
  autocmd BufNewFile,BufRead *.cpy setfiletype python
  autocmd BufNewFile,BufRead *.fab setfiletype python
  autocmd BufNewFile,BufRead *.rst setfiletype rest
  autocmd BufNewFile,BufRead *.txt setfiletype rest
  autocmd BufNewFile,BufRead *.cfg setfiletype cfg
  autocmd BufNewFile,BufRead *.kss setfiletype css
  autocmd BufNewFile,BufRead *.scala set filetype=scala
  autocmd! Syntax scala source ~/.vim/syntax/scala.vim
  autocmd BufNewFile,BufRead error.log setfiletype apachelogs
  autocmd BufNewFile,BufRead access.log setfiletype apachelogs
  autocmd BufRead,BufNewFile *.vcl setfiletype vcl

  " abbrevations
  autocmd FileType python abbr kpdb import pdb; pdb.set_trace()
  autocmd FileType python abbr kipdb from ipdb import set_trace; set_trace()

  " VIM footers
  autocmd FileType css abbr kvim /* vim: set ft=css ts=4 sw=4 expandtab : */
  autocmd FileType javscript abbr kvim /* vim: set ft=javscript ts=4 sw=4 expandtab : */
  autocmd FileType rst abbr kvim .. vim: set ft=rst ts=4 sw=4 expandtab tw=78 :
  autocmd FileType python abbr kvim # vim: set ft=python ts=4 sw=4 expandtab :
  autocmd FileType xml abbr kvim <!-- vim: set ft=xml ts=2 sw=2 expandtab : -->
  autocmd FileType html abbr kvim <!-- vim: set ft=html ts=2 sw=2 expandtab : -->
  autocmd FileType changelog abbr kvim vim: set ft=changelog ts=4 sw=4 expandtab :
  autocmd FileType cfg abbr kvim # vim: set ft=cfg ts=4 sw=4 expandtab :
  autocmd FileType config abbr kvim # vim: set ft=config ts=4 sw=4 expandtab :

  autocmd FileType * abbr ddate <C-R>=strftime("%Y-%m-%d")<CR>
  autocmd FileType * abbr nname Daniel Altiparmak<CR>

  autocmd BufNewFile *daily/*.rst 0r ~/.vim/skeletons/daily.rst
  autocmd BufNewFile *daily/*.rst ks|call Created()|'s

  autocmd BufNewFile *.py 0r ~/.vim/skeletons/skeleton.py
  autocmd BufNewFile *.py ks|call FileName()|'s
  autocmd BufNewFile *.py ks|call Created()|'s

  autocmd BufWritePre,FileWritePre * ks|call LastModified()|'s

  " load Templates with kmod
  autocmd FileType python abbr kmod :r ~/.vim/skeletons/skeleton.py
  autocmd FileType python abbr khead :r ~/.vim/skeletons/skeleton.head
  autocmd FileType rst abbr kmod :r ~/.vim/skeletons/skeleton.rst
  autocmd FileType zpt abbr kmod :r ~/.vim/skeletons/skeleton.pt
  autocmd FileType changelog abbr kmod :r ~/.vim/skeletons/skeleton.changelog
  autocmd FileType xml abbr kmod :r ~/.vim/skeletons/skeleton.zcml

  fun FileName()
    if line("$") > 20
      let l = 20
    else
      let l = line("$")
    endif
    exe "1," . l . "g/File Name: /s/File Name: .*/File Name: " .
    \ expand("%")
  endfun

  fun Created()
    if line("$") > 20
      let l = 20
    else
      let l = line("$")
    endif
    exe "1," . l . "g/Creation Date: /s/Creation Date: .*/Creation Date: " .
    \ strftime("%Y %b %d")
  endfun

  fun LastModified()
    if line("$") > 20
      let l = 20
    else
      let l = line("$")
    endif
    exe "1," . l . "g/Last Modified: /s/Last Modified: .*/Last Modified: " .
    \ strftime("%Y %b %d")
  endfun

  augroup END
endif
