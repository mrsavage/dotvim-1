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
  colorscheme solarized
  set background=dark
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
