set nu
set autoindent
set textwidth=0
set backspace=2
set tabstop=2     "Width of an existing tab
set expandtab     "Insert a number of spaces when tab is hit
set shiftwidth=2  "Number of spaces used for >> and <<
set softtabstop=2 "Width of a tab when inserting
set directory=/tmp

set splitbelow
set splitright

set t_Co=256
syntax enable
colorscheme rcr

set hlsearch
nnoremap <CR> :noh<Return><Esc>
autocmd InsertLeave * :setlocal hlsearch
autocmd InsertEnter * :setlocal nohlsearch

inoremap jj <Esc>
nmap <Space> i_<Esc>r

"w!! writes the file even if you don't have sudo permission
cmap w!! %!sudo tee > /dev/null %
