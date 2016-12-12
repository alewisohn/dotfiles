" Use the Solarized Dark theme
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=3

" Change buffers without saving them
set hidden

" Use the already open buffer if it exists
set switchbuf=useopen,usetab 

" For -x use, use something good
set cryptmethod=blowfish

" Filetype detection
autocmd BufRead,BufNewFile *.as set filetype=actionscript
autocmd BufRead,BufNewFile *.hx set filetype=haxe
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd BufRead,BufNewFile *.ino set filetype=arduino
autocmd BufRead,BufNewFile *.ncx set filetype=xml
autocmd BufRead,BufNewFile *.opf set filetype=xml
autocmd BufRead,BufNewFile *.jar,*.war,*.ear,*.sar,*.rar,*.epub set filetype=zip

" Visual bell and no beep
set vb
set noerrorbells

" Allow backspacing over everything in insert mode
set bs=indent,eol,start

" Change backup directory
"set backupdir=/tmp
" Change swp directory
"set directory=/tmp
" Turning these off as vim is messing up watching files
" Fuck a swp file
set nobackup
set nowritebackup
set noswapfile

" Turn on mouse
set mouse=a
set ttymouse=xterm2

" wrapping options
set nowrap

" Allow j and k keys to move down physical lines on screen
nnoremap j gj
nnoremap k gk
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

" Allow L and H to go to beginning and end of line respectively
nnoremap H 0
nnoremap L $

" I have yet to find a use for Ex mode
nnoremap Q <Nop>

" Scroll 3 lines at a time with C-y and C-x
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Make Y and D yank til the end of the line like other capital letters
map Y y$
map D d$

" Hide the toolbar
set go-=T

" Enable the status bar
set laststatus=2

" Keep some space between the current line and the window frame
set scrolloff=4

" 4 spaces, expand tab by default
set sw=4 sts=4 ts=4 expandtab

" Enable folding with the spacebar
nnoremap <space> za
vnoremap <space> zf

" See lines numbers, ruler, and current line
set number
set ruler
set cursorline

" set bash style word completion
set wildmode=longest:full
set wildmenu
set wildignore=*.swp,*.bak,*.pyc,*.class

" Search Options
" enable search highlighting
set hlsearch
" enable incremental search
set incsearch
" case-insensitive search
set ignorecase
" unless there's uppercase letters on the pattern
set smartcase
" do not move the cursor when highlighting
noremap * *N
noremap # #N

" Map shortcut leader to ',' instead of '/'
let mapleader = ","

" Clear the search highlight with <leader>n
nmap <silent> <leader>n :noh<CR>

" Paste mode toggle
nmap <silent> <leader>p :set paste!<CR>
" Softwarp text
nmap <silent> <leader>w :set wrap! linebreak! textwidth=0<CR>
" Toggle NERDTree
map <leader>t :NERDTreeToggle<CR>

" Toggle NERDTree
vmap <leader>s :sort<CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Opens a split command with the path of the currently edited file filled in
" Normal mode: <Leader>s
map <Leader>se :split <C-R>=expand("%:p:h") . "/" <CR>
" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>v
map <Leader>ve :vsplit <C-R>=expand("%:p:h") . "/" <CR>

let NERDTreeIgnore=['\.pyc']

set listchars=tab:>.,trail:.,extends:#,nbsp:.

" When splitting window, split to bottom and to right
set splitright
set splitbelow


" Resize windows when loading sessions
set sessionoptions+=resize

" After shifting a visual block, reselect it to be able to shift again
vnoremap > >gv
vnoremap < <gv

" Run current line/selection as Python code and replace with output
nmap gp :.!python<CR>
vmap gp :!python<CR>

" Move between windows with ctrl + movement keys
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

" Split to the file under the cursor and line number
map gs <C-W>F

" Turn on 256 colors if this is xterm or xterm compatible
set t_Co=256

" Remove some of the more annoying 'Press ENTER to continue' messages
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif
