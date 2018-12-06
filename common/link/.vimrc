" My new vimrc
"
" TODO:
" - helptags?
"mkdirp -p ~/.vim/pack/my-plugins/start
"cd ~/.vim/pack/my-plugins/start
"cabal update; cabal install happy hindent
"#then run :GoInstall in vim
"ctags
"syntax
"# can extend commentary with: autocmd FileType apache setlocal commentstring=#\ %s
" TODO: try to find a use for these
"git clone https://github.com/tpope/vim-speeddating.git
"git clone https://github.com/tpope/vim-unimpaired.git
"git clone https://github.com/vim-syntastic/syntastic.git
"git clone https://github.com/xolox/vim-easytags.git
"git clone https://github.com/xolox/vim-misc.git

"packadd! vim-easytags
"packadd! vim-speeddating
" etc.

" Import defaults.vim
runtime! defaults.vim

function! PackInit() abort
  packadd minpac
  if !exists('*minpac#init')
    " minpac is not available.
    " install it.
    silent !mkdir -p ~/.vim/pack/minpac/opt
    silent !git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
    call PackInit()
  
  else
    " minpac is available.
    call minpac#init()
  
    " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
    call minpac#add('k-takata/minpac', {'type': 'opt'})
  
    " Additional plugins here.
    call minpac#add('ctrlpvim/ctrlp.vim')
    call minpac#add('easymotion/vim-easymotion')
    call minpac#add('itchyny/lightline.vim')
    call minpac#add('lifepillar/vim-solarized8')
    call minpac#add('tpope/vim-commentary')
    call minpac#add('tpope/vim-dispatch')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-repeat')
    call minpac#add('tpope/vim-surround')
    " call minpac#add('mhinz/vim-grepper')
    " call minpac#add('tpope/vim-eunuch')
    " call minpac#add('tpope/vim-sensible')
    " call minpac#add('tpope/vim-sleuth')

    " Language support
    call minpac#add('fatih/vim-go')
    call minpac#add('rust-lang/rust.vim')
    " call minpac#add('alx741/vim-hindent')
    " call minpac#add('neovimhaskell/haskell-vim')
  endif
endfunction

" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

if has('gui_running')
  set guifont=Monaco:h16
  set background=dark
  colorscheme solarized8
endif

" " ensure that vimplug is installed
" if empty(glob('~/.vim/autoload/plug.vim'))
"   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

let mapleader=","
" used more for certain types of files
"let maplocalleader = "\\"

" Hide (rather than unload) abandoned buffers
set hidden

" Line numbers (but see https://github.com/vim/vim/issues/282)
"set relativenumber
"set number

" Ignore case only in lower-case searches
set ignorecase
set smartcase

" What characters can wrap between lines?
"set whichwrap+=<,>,h,l

" Always show status line and give more space for messages
set laststatus=2
set cmdheight=2

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
" set showmatch
" set matchtime=2


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

" toggle quickfix and location list relatively easily
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>co :copen<CR>
nnoremap <leader>lc :lclose<CR>
nnoremap <leader>lo :lopen<CR>

" vim-easymotion with Dvorak combas
let g:EasyMotion_keys = "aoeidtn',.pyfgcrl;qjkxbmuhs"

" vim-go
" let g:go_list_type = "quickfix"
" g:go_auto_type_info = 0
let g:go_fmt_command = "goimports"
" let g:go_metalinter_autosave = 0
" let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck', 'varcheck']
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'varcheck', 'ineffassign']
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'varcheck', 'ineffassign', 'megacheck']
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'varcheck', 'maligned', 'ineffassign', 'gosimple', 'staticcheck']
let g:go_metalinter_deadline = '30s'
nnoremap <leader>m :GoMetaLinter<CR>


let g:rustfmt_autosave = 1
