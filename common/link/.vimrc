" My new vimrc
"
" TODO:
" - helptags?
"mkdirp -p ~/.vim/pack/my-plugins/start
"cd ~/.vim/pack/my-plugins/start
"git clone https://github.com/fatih/vim-go.git
"git clone https://github.com/tpope/vim-commentary.git
"git clone https://github.com/tpope/vim-fugitive.git
"git clone https://github.com/tpope/vim-repeat.git
"git clone https://github.com/tpope/vim-surround.git
"git clone https://github.com/mhinz/vim-grepper.git
"git clone https://github.com/tpope/vim-unimpaired.git
"# https://github.com/tpope/vim-sensible.git
"#then run :GoInstall in vim
"ctags
"syntax
"# can extend the following with: autocmd FileType apache setlocal commentstring=#\ %s
" TODO: try to find a use for these
"git clone https://github.com/tpope/vim-dispatch.git
"git clone git://github.com/tpope/vim-speeddating.git
"git clone https://github.com/xolox/vim-easytags.git
"git clone https://github.com/xolox/vim-misc.git

"packadd! vim-dispatch
"packadd! vim-speeddating
"packadd! vim-unimpaired

""" default vimrc: https://github.com/vim/vim/blob/master/runtime/defaults.vim

" The default vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Jun 13
"
" This is loaded if no vimrc file was found.
" Except when Vim is run with "-u NONE" or "-C".
" Individual settings can be reverted with ":set option&".
" Other commands can be reverted as mentioned below.

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Bail out if something that ran earlier, e.g. a system wide vimrc, does not
" want Vim to use these default values.
if exists('skip_defaults_vim')
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

""" /default vimrc

" vim-go
let g:go_fmt_command = "goimports"

" Hide (rather than unload) abandoned buffers
set hidden

" Line numbers (but see https://github.com/vim/vim/issues/282)
set relativenumber
"set number

" Ignore case only in lower-case searches
set ignorecase
set smartcase

" What characters can wrap between lines?
"set whichwrap+=<,>,h,l

" Always show status line and give more space for messages
set laststatus=2
set cmdheight=2

let mapleader=","
" used more for certain types of files
"let maplocalleader = "\\"

" Fast saving
nnoremap <Leader>w :write!<CR>

" Highlight search results, but disable when <Leader><CR> is pressed
set hlsearch
" only highlight during search
" augroup vimrc-incsearch-highlight
"   autocmd!
"   autocmd CmdlineEnter /,\? :set hlsearch
"   autocmd CmdlineLeave /,\? :set nohlsearch
" augroup END


" Cycle between buffers
" 'Vim also has <C-^> (or <C-6> on some keyboards)—the normal mode equivalent of :b#—to jump between the current buffer and the previous one. Use it if you often alternate between two buffers.'
nnoremap gb :ls<CR>:b<Space>

" gd or gD: go to declaration
" g] or ctrl-]: go to definition or implementation


" Adapted from <https://stackoverflow.com/a/16084326>

"" Juggling with files
" Default includes at least .,, (relative to current working directory, plus directory of current file)
set path+=**
" Find files recursively under curent working directory
nnoremap <Leader>f :find *
nnoremap <Leader>s :sfind *
nnoremap <Leader>v :vert sfind *
nnoremap <Leader>t :tabfind *
" Skip entire parts of the current project to find files recursively under directory of current file
nnoremap <Leader>F :find <C-R>=expand('%:h').'/*'<CR>
nnoremap <Leader>S :sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <Leader>V :vert sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <Leader>T :tabfind <C-R>=expand('%:h').'/*'<CR>


"" Juggling with buffers
set wildcharm=<C-z>
nnoremap <Leader>b :buffer <C-z><S-Tab>
nnoremap <Leader>B :sbuffer <C-z><S-Tab>
"nnoremap <PageUp>   :bprevious<CR>
"nnoremap <PageDown> :bnext<CR>

"" Juggling withh tags
nnoremap <Leader>j :tjump /


"" Wildmenu
" Make file/buffer navigation easier
set wildmode=list:full
set wildignore=*.swp,*.bak
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*
" Search for both foo and Foo
set wildignorecase

"I recently found this gem in someone else's ~/.vimrc. It creates a file mark at the exact position of the cursor whenever you leave a buffer so that, wherever you are, 'J jumps to the latest JavaScript buffer you edited. Awesome.
"augroup VIMRC
"  autocmd!
"
"  autocmd BufLeave *.css  normal! mC
"  autocmd BufLeave *.html normal! mH
"  autocmd BufLeave *.js   normal! mJ
"  autocmd BufLeave *.php  normal! mP
"augroup END

" Don't use arrows to move around in normal, visual, or operator-pending modes
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Don't use arrow keys to move around in insert mode
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Toggle paste mode on and off
set pastetoggle=<Leader>p


" Jump for 2/10 of a second when typing matching parens
set showmatch
set matchtime=2


" misc
" set magic
" set lazyredrow
" change wildmod
" set wildmode=list:longest,full (from before)
" set wildmode=longest,list,full (commented out)
" " temporary, project, and minified files
" set wildignore=*.swp,*.bak,*.lock

" " tags
" set wildignore+=tags,TAGS

" " archives
" set wildignore+=*.tar.*,*.tgz,*.bz2,*.gz,*.tar

" " work at RED Interactive Agency
" set wildignore+=*/env/**/*
" set wildignore+=*/node_modules/**/*,*/collected-static/**/*

" " misc
" set wildignore+=*.db

" " multimedia
" set wildignore+=*.pdf,*.svg,*.eps,*.ai,*.png,*.jpg,*.jpeg,*.gif,*.tif,*.tiff


" " vim-easytags
" let g:easytags_cmd = '/usr/local/bin/exctags'
" let g:easytags_always_enabled = 0
" let g:easytags_async = 1
" let g:easytags_dynamic_files = 2
" let g:easytags_events = ['BufWritePost']
" let g:easytags_on_cursorhold = 0
" let g:easytags_resolve_links = 1


" vim-grepper
nnoremap <leader>g :Grepper -tool git<cr>
nnoremap <leader>G :Grepper -tool ag<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" toggle quickfix relatively easily
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>co :copen<CR>

" cherry-picked from vim-sensible: https://github.com/tpope/vim-sensible
set autoindent
set complete-=i
set smarttab
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
" set display+=lastline
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif
set autoread
if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options
" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

