" My new vimrc
"
" TODO:
" - helptags?
"mkdirp -p ~/.vim/pack/my-plugins/start
"cd ~/.vim/pack/my-plugins/start
"git clone https://github.com/easymotion/vim-easymotion.git
"git clone https://github.com/fatih/vim-go.git
"git clone https://github.com/mhinz/vim-grepper.git
"git clone https://github.com/tpope/vim-commentary.git
"git clone https://github.com/tpope/vim-dispatch.git
"git clone https://github.com/tpope/vim-fugitive.git
"git clone https://github.com/tpope/vim-repeat.git
"git clone https://github.com/tpope/vim-sensible.git
"git clone https://github.com/tpope/vim-surround.git
"#then run :GoInstall in vim
"ctags
"syntax
"# can extend commentary with: autocmd FileType apache setlocal commentstring=#\ %s
" TODO: try to find a use for these
"git clone https://github.com/tpope/vim-sleuth.git
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

" vim-go
" let g:go_list_type = "quickfix"
" g:go_auto_type_info = 0
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 0
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck', 'varcheck']
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'varcheck', 'aligncheck', 'ineffassign', 'gosimple', 'staticcheck']
let g:go_metalinter_deadline = '10s'

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

" toggle quickfix and location list relatively easily
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>co :copen<CR>
nnoremap <leader>lc :lclose<CR>
nnoremap <leader>lo :lopen<CR>
