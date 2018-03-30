" An example for a vimrc file.
" Lots of stuff adapted (read: taken) from: http://amix.dk/vim/vimrc.html
"
" Maintainer: Bram Moolenaar <Bram@vim.org>
" Last change:  2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"       for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"     for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif


"""" NeoBundle
let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
  let g:make = 'make'
endif

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  runtime bundle/vim-pathogen/autoload/pathogen.vim
  execute pathogen#infect()
  execute pathogen#helptags()
endif

"
"NeoBundle 'rbgrouleff/bclose.vim'
"NeoBundle 'sickill/vim-monokai'
"NeoBundle 'tomasr/molokai'
"NeoBundle 'danchoi/soywiki'
"" Lokaltog/powerline-fonts
""NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"" gist repos

"
""NeoBundle 'chrisbra/SudoEdit.vim'
""bclose and soywiki
""NeoBundle 'chrisbra/csv.vim'
""NeoBundle 'mattn/emmet-vim'
""NeoBundle 'Shougo/neocomplete.vim'
"NeoBundle 'scrooloose/syntastic'
"NeoBundle 'tomtom/tcomment_vim'
"NeoBundle 'mileszs/ack.vim'
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'tpope/vim-dispatch'
""NeoBundle 'Lokaltog/vim-easymotion'
"NeoBundle 'xolox/vim-easytags'
"NeoBundle 'tpope/vim-fugitive'
""NeoBundle 'airblade/vim-gitgutter'
"NeoBundle 'xolox/vim-misc'
""NeoBundle 'tpope/vim-pathogen'
"NeoBundle 'tpope/vim-scriptease'
"NeoBundle 'tpope/vim-sensible'
"NeoBundle 'xolox/vim-session'
"NeoBundle 'tpope/vim-sleuth'
"NeoBundle 'tpope/vim-surround'
"NeoBundle 'jmcantrell/vim-virtualenv'
""NeoBundle 'ctrlpvim/ctrlp.vim'

" gitgutter
let g:gitgutter_map_keys = 0

" Disable session autoload/autosave
let g:session_autoload = 'no'
let g:session_autosave = 'no'

" [TODO] configure more syntax stuff, maybe a Python lang switcher, etc.?
"let g:syntastic_python_python_exec = 'python2'
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Use tpope's vim-dispatch to fork off searches
let g:ack_use_dispatch = 1
let g:ackhighlight = 1
" --nofilter crucial to prevent search being of stdin (causing stall) in gvim
let g:ack_default_options = " -s -H --nocolor --nogroup --column --nofilter"

"let grepprg_bak=&grepprg
"let grepformat_bak=&grepformat
"let shellpipe_bak=&shellpipe
"try
"  " workaround for haskellvim
"  let &shellpipe=">"
"  let &grepprg=g:ackprg
"  let &grepformat=g:ackformat
"  silent execute a:cmd . " " . escape(l:grepargs, '|')
"finally
"  let &grepprg=grepprg_bak
"  let &grepformat=grepformat_bak
"  let &shellpipe=shellpipe_bak
"endtry

" Tags
let g:easytags_dynamic_files = 2
let g:easytags_async = 1
let g:easytags_always_enabled = 0
let g:easytags_on_cursorhold = 1
let g:easytags_resolve_links = 1
let g:easytags_events = ['BufWritePost']

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
"let g:tagbar_autopreview = 1
let g:tagbar_sort = 0

"nnoremap <leader>t
"autocmd VimEnter * nested :call tagbar#autoopen(1)

"" Close buffer
"nnoremap <silent> <leader>cb :close<CR>

" Show line numbers
" [BUG] https://github.com/vim/vim/issues/282
set relativenumber
set number



""" NERDTree

" open a NERDTree automatically when vim starts up if no files were specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | wincmd p | endif

" map a specific key or shortcut to open NERDTree
noremap <C-n> :NERDTreeToggle<CR>
" noremap <C-n> :NERDTreeFromBookmark<Space>

" close vim if the only window left open is a NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" don't highlight cursor column in NERDTree
autocmd FileType nerdtree setlocal nocursorcolumn

" ignore some extensions
let NERDTreeIgnore = ['\.pyc$']

""" end NERDTree

"" Set font
"if has("gui_running") && has("gui_macvim")
"  "set guifont=Source\ Code\ Pro\ for\ Powerline:h13
"  set guifont=Meslo\ LG\ S\ for\ Powerline:h13
"elseif has("gui_running")
"    set guifont=Luxi\ Mono\ 13
"endif

" Highlight line and column
" [BUG] https://github.com/vim/vim/issues/282
"set cursorline
"set cursorcolumn
set colorcolumn=80

" Press space to clear search highlighting and any message already displayed.
"nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

" Colorscheme
"colorscheme solarized
"set background=dark

"" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
"" let &guioptions = substitute(&guioptions, "t", "", "g")
"
"" Don't use Ex mode, use Q for formatting
"map Q gq
"
"" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
"" so that you can undo CTRL-U after inserting a line break.
"inoremap <C-U> <C-G>u<C-U>
"
"" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif
"
"" Switch syntax highlighting on, when the terminal has colors
"" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
"  syntax on
"  set hlsearch
"endif

" Only do this part when compiled with support for autocommands.
"if has("autocmd")
"
"  " Enable file type detection.
"  " Use the default filetype settings, so that mail gets 'tw' set to 72,
"  " 'cindent' is on in C files, etc.
"  " Also load indent files, to automatically do language-dependent indenting.
"  filetype plugin indent on
"
"  " Put these in an autocmd group, so that we can delete them easily.
"  augroup vimrcEx
"  au!
"
"  " For all text files set 'textwidth' to 78 characters.
"  autocmd FileType text setlocal textwidth=78
"
"  " When editing a file, always jump to the last known cursor position.
"  " Don't do it when the position is invalid or when inside an event handler
"  " (happens when dropping a file on gvim).
"  " Also don't do it when the mark is in the first line, that is the default
"  " position when opening a file.
"  autocmd BufReadPost *
"    \ if line("'\"") > 1 && line("'\"") <= line("$") |
"    \   exe "normal! g`\"" |
"    \ endif
"
"  augroup END
"
"else
"
"endif " has("autocmd")
"
"" Convenient command to see the difference between the current buffer and the
"" file it was loaded from, thus the changes you made.
"" Only define it when not defined already.
"if !exists(":DiffOrig")
"  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
"      \ | wincmd p | diffthis
"endif
"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
" Version: 
"       5.0 - 29/05/12 15:43:36
"
" Blog_post: 
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
"
" Raw_version: 
"       http://amix.dk/vim/vimrc.txt
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Adapted from http://nvie.com/posts/how-i-boosted-my-vim/
" Finally, a trick by Steve Losh for when you forgot to sudo before editing a file that requires root privileges (typically /etc/hosts). This lets you use w!! to do that after you opened the file already:
"cmap w!! w !sudo tee % >/dev/null



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore compiled files
"set wildignore=*.o,*~,*.pyc
"set wildignore+=*.o,*~,*.pyc,*.log,*.ser,*.zip,*.png,*.gif,*.jpg,*.pdf,*.swp,*.bak

" Height (in lines) of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
"syntax on

" Highlight unwanted spaces (at EOL or before a tab)
"autocmd BufReadPost * match ErrorMsg /\s\+\%#\@<!$\| \+\ze\t/
"autocmd InsertEnter * match ErrorMsg /\s\+\%#\@<!$\| \+\ze\t/
"autocmd InsertLeave * match ErrorMsg /\s\+\%#\@<!$\| \+\ze\t/
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
"autocmd BufReadPost * match ExtraWhitespace /\s\+\%#\@<!$\| \+\ze\t/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$\| \+\ze\t/
"autocmd InsertLeave * match ExtraWhitespace /\s\+\%#\@<!$\| \+\ze\t/

" colorscheme solarized
" set background=dark

" " Set extra options when not running in GUI mode
"if !has("gui_running")
"  "set guioptions+=e
"  set t_Co=256
"  " colorscheme solarized
"  " set background=dark
"  "set guitablabel=%M\ %t
"endif

" " Set utf-8 as standard encoding
" if has("multi_byte")
"   if &termencoding == ""
"     let &termencoding = &encoding
"   endif
"   set encoding=utf-8
"   setglobal fileencoding=utf-8
"   "setglobal bomb
"   set fileencodings=utf-8,latin1
" endif

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
"set expandtab

" 1 tab == 4 spaces
"set shiftwidth=4
set tabstop=8
"set softtabstop=4 " [TODO] disabled 2015-01-10 to see if we need it

" Linebreak on 500 characters
set lbr
set tw=500

set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
" " This is handy until relative line numbering is used and motion
" " becomes inaccurate.  [TODO] workaround?
"map j gj
"map k gk

" " Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" map <space> /
" map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <leader><cr> :nohlsearch<cr>

" Smart way to move between windows
"nnoremap <silent> <Leader>j :wincmd j<CR>
"nnoremap <silent> <Leader>k :wincmd k<CR>
"nnoremap <silent> <Leader>h :wincmd h<CR>
"nnoremap <silent> <Leader>l :wincmd l<CR>

" Close the current buffer
"map <leader>bc :Bclose<cr>

" Close all the buffers
"map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
"map <leader>tn :tabnew<cr>
"map <leader>to :tabonly<cr>
"map <leader>tc :tabclose<cr>
"map <leader>tm :tabmove
"
"" Opens a new tab with the current buffer's path
"" Super useful when editing files in the same directory
"map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Opens a new buffer with the current buffer's path
" Super useful when editing files in the same directory
map <leader>de :edit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

"" Specify the behavior when switching between buffers
"try
"  set switchbuf=useopen,usetab,newtab
"  set showtabline=1
"catch
"endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
" Remember info about open buffers on close
" set viminfo^=%


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  " Mark cursor position to restore
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

nnoremap <Leader>cw :call DeleteTrailingWS()<CR>
"autocmd BufWritePre *.py :call DeleteTrailingWS()
" autocmd BufWritePre *.coffee :call DeleteTrailingWS()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => vimgrep searching and cope displaying
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" When you press gv you vimgrep after the selected text
"vnoremap <silent> gv :call VisualSelection('gv')<CR>
"
"" Open vimgrep and put the cursor in the right position
"map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>
"
"" Vimgreps in the current file
"map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>
"
"" When you press <leader>r you can search and replace the selected text
"vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>
"
"" Do :help cope if you are unsure what cope is. It's super useful!
""
"" When you search with vimgrep, display your results in cope by doing:
""   <leader>cc
""
"" To go to the next search result do:
""   <leader>n
""
"" To go to the previous search results do:
""   <leader>p
""
"map <leader>cc :botright cope<cr>
"map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
"map <leader>n :cn<cr>
"map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>M mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
"map <leader>pp :setlocal paste!<cr>
set pastetoggle=<Leader>p



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  en
  return ''
endfunction

" Don't close window, when deleting a buffer
"command! Bclose call <SID>BufcloseCloseIt()
"function! <SID>BufcloseCloseIt()
"   let l:currentBufNum = bufnr("%")
"   let l:alternateBufNum = bufnr("#")
"
"   if buflisted(l:alternateBufNum)
"     buffer #
"   else
"     bnext
"   endif
"
"   if bufnr("%") == l:currentBufNum
"     new
"   endif
"
"   if buflisted(l:currentBufNum)
"     execute("bdelete! ".l:currentBufNum)
"   endif
"endfunction

""""" End ultimate vimrc

" Courtesy http://learnvimscriptthehardway.stevelosh.com/chapters/12.html
"autocmd FileType javascript nnoremap <buffer> <localleader>c I//
"autocmd FileType python     nnoremap <buffer> <localleader>c I#

" Use ack-grep as grep tool
"set grepprg=ack-grep\ -a

" Search through source files (a = 'ack')
"nnoremap <Leader>a :GitGrep<Space>

" Project-wide search
" nnoremap <Leader>f :Ack --ignore-case<Space>

" ctrl-p--open files
" project-wide files, then subdir files

" project-wide search, then subdir search
" nnoremap <Leader>g :Ack --ignore-case<Space>
" nnoremap <Leader>G :Ack<Space>

"let g:neocomplete#enable_cursor_hold_i = 1
"
"""" adapted from https://github.com/Shougo/neocomplete.vim
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
"" Define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }
"
"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()
"
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"  return neocomplete#close_popup() . "\<CR>"
"  " For no inserting <CR> key.
"  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplete#close_popup()
"inoremap <expr><C-e>  neocomplete#cancel_popup()
"" Close popup by <Space>.
""inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
"
"" For cursor moving in insert mode(Not recommended)
""inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
""inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
""inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
""inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
"" Or set this.
""let g:neocomplete#enable_cursor_hold_i = 1
"" Or set this.
""let g:neocomplete#enable_insert_char_pre = 1
"
"" AutoComplPop like behavior.
""let g:neocomplete#enable_auto_select = 1
"
"" Shell like behavior(not recommended).
""set completeopt+=longest
""let g:neocomplete#enable_auto_select = 1
""let g:neocomplete#disable_auto_complete = 1
""inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"
"" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"
"" Enable heavy omni completion.
"if !exists('g:neocomplete#sources#omni#input_patterns')
"  let g:neocomplete#sources#omni#input_patterns = {}
"endif
""let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
""let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
""let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"
"" For perlomni.vim setting.
"" https://github.com/c9s/perlomni.vim
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"""" end adaptation

"" Escape more easily
"inoremap jw <Esc>
"inoremap wj <Esc>

""" adapted from http://stackoverflow.com/questions/16082991/vim-switching-between-files-rapidly
" Switch buffers (could also be :buffers<CR>:buffer<Space>)
nnoremap gb :ls<CR>:b<Space>
"nnoremap <Leader>bb :b<Space>
"nnoremap <Leader>bs :sb<Space>
"nnoremap <Leader>bv :vert sb<Space>

" In project
" nmap <unique> <leader>f <Plug>(FerretAck)

set path=.,**

" https://stackoverflow.com/questions/16082991/vim-switching-between-files-rapidly-using-vanilla-vim-no-plugins
"
" search project
nnoremap <leader>f :find *
nnoremap <leader>s :sfind *
nnoremap <leader>v :vert sfind *
nnoremap <leader>t :tabfind *

" search under directory of current file
nnoremap <leader>F :find <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>S :sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>V :vert sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>T :tabfind <C-R>=expand('%:h').'/*'<CR>


" Juggle tags
"nnoremap <leader>t :tjump /

""" wildmenu, wildignore

"" Bash-like autocomplete
" set wildmode=longest,list,full

"set completeopt=longest,menuone
set wildmode=list:longest,full

set wildignorecase

" temporary, project, and minified files
set wildignore=*.swp,*.bak,*.lock
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*

" source control
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*

" tags
set wildignore+=tags,TAGS

" archives
set wildignore+=*.tar.*,*.tgz,*.bz2,*.gz,*.tar

" work at RED Interactive Agency
set wildignore+=*/env/**/*
set wildignore+=*/node_modules/**/*,*/collected-static/**/*

" misc
set wildignore+=*.db

" multimedia
set wildignore+=*.pdf,*.svg,*.eps,*.ai,*.png,*.jpg,*.jpeg,*.gif,*.tif,*.tiff

""" end wildignore

"set wildcharm=<C-z>
"nnoremap <leader>b :buffer <C-z>
"nnoremap <leader>B :sbuffer <C-z>

"nnoremap <PageUp>   :bprevious<CR>
"nnoremap <PageDown> :bnext<CR>

"" Marks
"augroup VIMRC
"  autocmd!
"
"  autocmd BufLeave *.css  normal! mC
"  autocmd BufLeave *.html normal! mH
"  autocmd BufLeave *.js   normal! mJ
"  autocmd BufLeave *.php  normal! mP
"augroup END

""" end

" A "meta" thing: edit/source (g)vimrc
nnoremap <silent> <Leader><space>ev :edit $MYVIMRC<CR>
nnoremap <silent> <Leader><space>eg :edit $MYGVIMRC<CR>
nnoremap <silent> <Leader><space>sv :source $MYVIMRC<CR>
nnoremap <silent> <Leader><space>sg :source $MYGVIMRC<CR>

" Remap semicolon to parenthesis
"nnoremap ; :

"set undolevels=1000      " use many muchos levels of undo

" Disable macros ([TODO] not perfect... somehow still able to enable)
nnoremap <silent> Q <nop>
nnoremap <silent> q <nop>

" Don't move around in normal, visual, or operator-pending modes
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Don't move around in insert mode
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

"""" Ctrl-P
"" <http://kien.github.io/ctrlp.vim/>
"
"""let g:ctrlp_working_path_mode = 'ra' " or maybe 'c' or 'w' or even 0
"""let g:ctrlp_mruf_relative = 1
""let g:ctrlp_extensions = ['whitespace', 'tag', 'buffertag', 'mixed']
"""let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
"""let g:ctrlp_custom_ignore = {
"""  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"""  \ 'file': '\v\.(exe|so|dll|jar|pdf|jpg|png|gif|log|bak|class|DS_Store)$',
"""  \ 'link': 'some_bad_symbolic_links',
"""  \ }
""
"nnoremap <Leader>p :CtrlP<CR>
"nnoremap <Leader>P :CtrlPClearAllCaches<CR>
"
"" nnoremap <Leader>b :CtrlPBuffer<CR>
"" nnoremap <Leader>r :CtrlPMRUFiles<CR>
"
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"""nnoremap <Leader>m :CtrlPMixed<CR>
""
""nnoremap <Leader>t :CtrlPBufTag<CR>
"""nnoremap <Leader>T :CtrlPBufTagAll<CR>
""nnoremap <Leader>y :CtrlPYankring<CR>
"""nnoremap <Leader>cl :CtrlPCmdline<CR>
""" N.B.: This clashes with Soywiki
"""nnoremap <Leader>d :CtrlPDir<CR>
"
"""" end Ctrl-P

""" COMMAND MAP FOR SELF
" K => help for currently selected vim command (c/o scriptease)
" <Leader>n => disable search highlight (wincent/loupe, default)
" <Leader>t => search files (wincent/command-t, default)
" <Leader>b => search buffers (wincent/command-t, default)
" <Leader>c => search tags (wincent/command-t); mnemonic is "ctags"
" <Leader>T => flush command-t cache (wincent/command-t)
"" <Leader>f => Ack search (wincent/ferret, default)
"" <Leader>l => Lack (location-list) search (wincent/ferret, default)
"" <Leader>r => Acks to do multi-file replace on quickfix from previous Ack invocation (wincent/ferret, default)
" <Leader>cw => clean trailing whitespace
" <leader>de => open new file in same directory (can complete path)
" <leader>L => show invisibles
" <Leader>M => remove ^M when Windows encodings get messed up
" <Leader><CR> => disable highlight (e.g., after a search)
" <leader>p => toggle paste mode
" <Leader>q => scratch buffer

" "Defunct
" <leader>bc => close buffer (but not window)

" Show invisibles
" Adapted from <http://vimcasts.org/episodes/show-invisibles/>
nmap <leader>L :set list!<CR>
set list
"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
"set listchars=eol:$
set fillchars+=vert:│

" Set background color for current line
"highlight CursorLine term=NONE cterm=NONE ctermbg=darkgray
"highlight CursorColumn term=NONE cterm=NONE ctermbg=darkgray
"highlight ColorColumn term=NONE cterm=NONE ctermbg=darkgray
highlight VertSplit term=NONE cterm=NONE  ctermbg=NONE
highlight NonText term=NONE cterm=NONE ctermfg=darkgray
highlight SpecialKey term=NONE cterm=NONE ctermfg=darkgray

nnoremap <leader>r :!racket %<CR>
