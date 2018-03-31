" My new vimrc

let mapleader=","
" used more for certain types of files
"let maplocalleader = "\\"

" Fast saving
nnoremap <Leader>w :write!<CR>

" Cycle between buffers
" 'Vim also has <C-^> (or <C-6> on some keyboards)—the normal mode equivalent of :b#—to jump between the current buffer and the previous one. Use it if you often alternate between two buffers.'
nnoremap gb :ls<CR>:b<Space>

" gd or gD: go to declaration
" g] or ctrl-]: go to definition or implementation


" Adapted from <https://stackoverflow.com/a/16084326>

"" Juggling with files
set path=.,**
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
nnoremap <PageUp>   :bprevious<CR>
nnoremap <PageDown> :bnext<CR>

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

