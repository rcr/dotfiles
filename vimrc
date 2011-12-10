set nu
set ruler
set rulerformat=%40(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
set autoindent

set tabstop=2       "Width of an existing tab
set softtabstop=2   "Width of a tab when inserting
set noexpandtab     "Insert a number of spaces when tab is hit
set shiftwidth=2    "Number of spaces used for >> and <<

set backspace=2
set textwidth=0

set t_Co=256

syntax enable
colorscheme xoria256

"directory for swap files
set directory=/tmp

"single character insert mapping:
nmap <Space> i_<Esc>r

"w!! writes the file even if you don't have sudo permission
cmap w!! %!sudo tee > /dev/null %

inoremap jj <Esc>

"move a line with alt+jk, indent with alt+hl (visual blocks as well)
"the ^[ character is: ctrl+v,ctrl+[
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
nnoremap <C-h> <<
nnoremap <C-l> >>
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
inoremap <C-h> <Esc><<`]a
inoremap <C-l> <Esc>>>`]a
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv
vnoremap <C-h> <gv
vnoremap <C-l> >gv

"remove ctrl+p and ctrl+n word completion
imap <C-n> <nop>
imap <C-p> <nop>

"Ctrl-Space for omnicompletion and keyword completion if omni is not available:
"imap <C-Space> <C-@>

"filetype plugin on
"set ofu=syntaxcomplete#Complete
