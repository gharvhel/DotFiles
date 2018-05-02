" File              : /home/gharvhel/.vimrc
" Author            : Gharvhel Carre <gc2767@columbia.edu>
" Date              : 01.05.2018
" Last Modified Date: 01.05.2018
" Last Modified By  : Gharvhel Carre <gc2767@columbia.edu>

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

set nocompatible                " required
filetype off                    " required
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Install plugins
"   1) declare the list of plugins you want to use in .vimrc
"   2) reload it (:source ~/.vimrc) or restart Vim
"   3) run :PlugInstall
" Update plugin
"   1) :PlugUpdate
"   2) :PlugDiff
" delete plugins
"   1) Delete or comment out Plug commands for the plugins
"   2) Reload vimrc (:source ~/.vimrc) or restart Vim
"   3) Run :PlugClean. It will detect and remove undeclared plugins.

" ----- Making Vim look good ------------------------------------------
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" ----- C and C++ IDE -------------------------------------------------
Plug 'WolfgangMehner/c-support'

" ----- Vim as a programmer's text editor -----------------------------
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-syntastic/syntastic'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
  " From within normal mode, press Ctrl + P, and start typing
  " Press Enter to open the file, or Ctrl + T to open in a new tab.
Plug 'ctrlpvim/ctrlp.vim'
  " switch header <-> .cpp and visa versa
Plug 'vim-scripts/a.vim'
  " Auto completion
Plug 'Valloric/YouCompleteMe'
  " Code Folding
Plug 'tmhedberg/SimpylFold'
  " Headers
Plug 'alpertuna/vim-header'
" ----- Working with Git ----------------------------------------------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'

" ----- Python -----------------------------------
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'
"Plug 'python-mode/python-mode'
" ----- Other text editing features -----------------------------------
Plug 'Raimondi/delimitMate'

" ---- Extras/Advanced plugins ----------------------------------------
" Highlight and strip trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
Plug 'christoomey/vim-tmux-navigator'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Enable file type detection.
filetype plugin indent on    " required
" ----- General Settings ---------------------------------------------------

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set clipboard=unnamed  " cut, copy, and/or paste to/from
                       " other applications outside of VIM

set history=1000       " keep 1000 lines of command line history
set number             " line numbers
set numberwidth=1      " line number indentation
set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands
set incsearch          " do incremental searching
set linebreak          " wrap lines on 'word' boundaries
set scrolloff=3        " don't let the cursor touch the edge of the viewport
set splitright         " Vertical splits use right half of screen
"set timeoutlen=100     " Lower ^[ timeout
set fillchars=fold:\ , " get rid of obnoxious '-' characters in folds
"set tildeop            " use ~ to toggle case as an operator, not a motion
if exists('&breakindent')
  set breakindent      " Indent wrapped lines up to the same level
endif

" Enable folding
set foldmethod=indent
set foldlevel=99

" Split options
set splitbelow
set splitright

" Tab settings
set expandtab          " Expand tabs into spaces
set tabstop=2          " default to 2 spaces for a hard tab
set softtabstop=2      " default to 2 spaces for the soft tab
set shiftwidth=2       " for when <TAB> is pressed at the beginning of a line

" We need this for plugins like Syntastic and vim-gitgutter which put symbols
" in the sign column.
hi clear SignColumn

" ----- backup settings ---------------------------------------------------
" Save your backup files to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or .
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swap files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backup files, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

" ----- Virtualenv Support -----------------------------------------------
" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" ----- Convenience command ------------------------------------------------

" Use :C to clear hlsearch
command! C nohlsearch

" ----- Custom keybindings -------------------------------------------------

" remap jk kj to escape
imap jk <Esc>
imap kj <Esc>

" Enable folding with the spacebar
nnoremap <space> za

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" change leader key
let mapleader=","

" Make navigating long, wrapped lines behave like normal lines
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$
noremap <silent> ^ g^
noremap <silent> _ g_

" ----- Terminal-as-GUI settings -------------------------------------------

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" ==== python settings =====
let python_highlight_all=1

" ----- Not-quite-general-but-don't-belong-anywhere-else Settings ----------

augroup vimrc
  " Clear the current autocmd group, in case we're re-sourcing the file
  au!

  " Jump to the last known cursor position when opening a file.
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

augroup END

" ----- Filetype Settings --------------------------------------------------

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  augroup myFiletypes
    autocmd!

    " Patch filetypes for common extensions

    " SML signature files
    autocmd BufRead,BufNewFile *.sig setlocal filetype=sml
    " Markdown files
    autocmd BufRead,BufNewFile *.md setlocal filetype=markdown
    " LaTeX class files
    autocmd BufRead,BufNewFile *.cls setlocal filetype=tex
    " Amethyst config file
    autocmd BufRead,BufNewFile .amethyst setlocal filetype=json
    " Python files
    autocmd BufNewFile,BufRead *.py setlocal filetype=python

    " Turn off tabs to space conversion for Makefiles
    autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

    " Turn on spell checking and 74-char lines by default for these filetypes
    autocmd FileType markdown,tex setlocal spell
    autocmd FileType markdown,tex setlocal tw=74

    " *.txt files
    autocmd FileType text setlocal autoindent expandtab softtabstop=2 textwidth=77 spell spelllang=en_us

    " Don't do spell-checking on Vim help files
    autocmd FileType help setlocal nospell

    " Python file settings
    autocmd Filetype python setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=76 expandtab autoindent fileformat=unix encoding=utf-8

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" ----- Mapping ------------------------------------------------------------
" make it easier to edit vim
" quickly edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Cycle through buffers
"map <leader>n :bn<cr>
"map <leader>p :bp<cr>
"map <leader>d :bd<cr>

" ----- Plugin-Specific Settings -------------------------------------------
" ----- rafi/awesome-vim-colorschemes --------------------------------------
"set background=dark
"colorscheme molokai

" ----- WolfgangMehner/c-support -------------------------------------------
" To enable the tools for cmake or doxygen, add these lines to ~/.vimrc :
let  g:C_UseTool_cmake    = 'yes'
let  g:C_UseTool_doxygen = 'yes'
" Change map leader for C.vim
let g:C_MapLeader  = ','
" let g:C_CFlags = '-Wall -g -o0 -c Classes.cpp Cat.cpp'
" let g:C_LFlags = '-Wall -g -o0 Classes.o Cat.o'
" let g:C_CplusCFlags = '-Wall -g -o0 -c Classes.cpp Cat.cpp'
" let g:C_CplusLFlags = '-Wall -g -o0 Classes.o Cat.o'
let g:C_CCompiler = "clang"
let g:C_CplusCompiler = "clang++"
let g:C_LineEndCommColDefault = "34"
let g:C_InsertFileHeader = 'no'
" ----- bling/vim-airline settings -----
" Always show statusbar
set laststatus=2

" Fancy arrow symbols, requires a patched font
" To install a patched font, run over to
"     https://github.com/abertsch/Menlo-for-Powerline
" Finally, uncomment the next line
let g:airline_powerline_fonts = 1

" Show PASTE if in paste mode
let g:airline_detect_paste=1

" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1

" Use the solarized theme for the Airline status bar
"let g:airline_theme='molokai'

" ----- jistr/vim-nerdtree-tabs -----
" Open/close NERDTree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>

" Open NERDTree automatically
"autocmd vimenter * NERDTree

" To have NERDTree always open on startup
"let g:nerdtree_tabs_open_on_console_startup = 1

" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NERDTree automatically when vim starts up on opening a directory
"let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ----- scrooloose/syntastic settings -----
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_python_checkers = ['pylint', 'flake8']
let g:syntastic_python_checkers = ['pylint']
"let g:syntastic_python_checker_args='--ignore=E501'
let g:syntastic_loc_list_height=5
"let g:syntastic_python_flake8_args = '--ignore=E,W,F403'
" ----- xolox/vim-easytags settings -----
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)

" ----- airblade/vim-gitgutter settings -----
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" ----- ntpeters/vim-better-whitespace setting -----------------------------
"  enable highlighting and stripping whitespace on save by default
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" --- YouCompleteMe Settings ----
"  for c/c++ support
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" completion while commenting
let g:ycm_complete_in_comments = 1

" ===== git-nerdtree ======
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
"hide .pyc files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" ===== Simply Fold =====
" see the docstrings for folded code
let g:SimpylFold_docstring_preview=1

" ===== vim-header =====
let g:header_field_author = 'Gharvhel Carre'
let g:header_field_author_email = 'gc2767@columbia.edu'
let g:header_max_size = 7
map <F4> :AddHeader<CR>

" ===== python-mode =====
"let g:pymode_python = 'python'
