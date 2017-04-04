"
" Personal configuration file for VIM
" ~/.vimrc
"
" Pierre Leroux
" Created on 22/03/2017
"


" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Replace leader caracter
let mapleader = ","

" Use pathogen to easily modify the runtime path to include all plugins under
" the ~/.vim/bundle directory
filetype off                    " force reloading *after* pathogen loaded
call pathogen#infect('bundle/{}', '~/src/vim/bundle/{}')
call pathogen#helptags()

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Backup for each file editing 
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

set undofile		" keep an undo file (undo changes after closing)
set history=50		" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" enable mode mouse, allow selection of block and resizing the workflow
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" An autocommand is a command that is executed automatically in response to
" some event, such as a file being read or written or a buffer change.
" autocmd always enable on moden terminal
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit

" Display the number of each line
set number

" color kit for background color dark allow to display the bright color
set background=dark

" 4 spaces tabulation
set tabstop=4
set shiftwidth=4

" insert tabs on the start of a line according to
" shiftwidth, not tabstop
set smarttab

" Close the bracket after each opening
inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>

" auto close html tag
abbr </> </<C-x><C-O>

" Highlight all caracters that exceeds 80 colons
highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%80v.\+/

" Enable folding
set foldenable

" p en mode Visuel remplace le texte sélectionné par le registre "".
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Highlight current line
set cursorline

" highlight matching [{()}])
set showmatch

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" save session
nnoremap <leader>s :mksession<CR>

"keep 4 lines off the edges when scrolling
set scrolloff=4

" Toggle show/hide invisible caracters 
nnoremap <leader>i :set list!<cr>

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

let g:DoxygenToolkit_briefTag_pre="\\brief "
let g:DoxygenToolkit_paramTag_pre="\\param "
let g:DoxygenToolkit_returnTag="\\return "
let g:DoxygenToolkit_blockHeader="-----------------"
let g:DoxygenToolkit_blockFooter="-----------------"
let g:DoxygenToolkit_authorName="Pierre LEROUX"
"let g:DoxygenToolkit_licenseTag="My own license"   <-- !!! Does not end with \"\<enter>"

nnoremap <leader>w <C-w>v
nnoremap <leader>, <C-w>w
nnoremap <leader>q :wq<cr>
nnoremap <leader>t :tabnext<cr>

"EOF"
