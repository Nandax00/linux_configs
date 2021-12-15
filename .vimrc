execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype plugin indent on

set termguicolors

colorscheme horizon

" lightline
let g:lightline = {'colorscheme' : 'horizon'}

" Robot syntax highlight
hi link robotKEYWORD PreProc
hi robotARGUMENT cterm=underline

set smartindent
set shell=bash\ -i
set mouse=a
set tabstop=4
set shiftwidth=4
set expandtab
set number
set ruler
set list
set shiftround
set nobackup
set showcmd
set ignorecase
set backspace=indent,eol,start
set autoindent
set hlsearch
set incsearch
set tabpagemax=100
set wildmode=longest:full
set wildmenu
set colorcolumn=80

" PYMODE SETTINGS
let g:pymode = 1
let g:pymode_options = 1
let g:pymode_options_colorcolumn = 1

" Sets the terminal window's scroolback buffer size
let g:terminal_scrollback_buffer_size = 100000

"""""""""""""""""""""""""
" LEADER-BASED SETTINGS "
"""""""""""""""""""""""""

let mapleader="-"
let maplocalleader=","

aug python
	au!
	au FileType python setlocal nowrap
	au FileType python setlocal list
	au FileType python nnoremap <buffer> <localleader>c I# <esc>
	au BufWritePre *.py :%s/\s\+$//e 
aug END
aug robot
	au!
	au BufNewFile,BufRead *.robot set filetype=robot
	au FileType robot nnoremap <buffer> <localleader>c I# <esc>
	au BufWritePre *.robot :%s/\s\+$//e 
aug cplusplus
	au!
	au FileType cpp nnoremap <buffer> <localleader>c I//<esc>
aug END
aug html
	au!
	" Fold tag content
	au FileType html nnoremap <buffer> <localleader>f Vatzf
aug END
aug markdown
	au!
	au FileType markdown onoremap <buffer> ih :<c-u>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rkvg_"<cr>
	au FileType markdown onoremap <buffer> ah :<c-u>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rg_vk0"<cr>
aug END

" Copies the path of the current file to the clipboard
nmap <leader>pwd :let @+=expand("%:p")<CR>

inoremap <leader><c-u> <esc>viwU<esc>ea
inoremap jk <esc>
nnoremap <leader><c-u> viwU<esc>e
nnoremap <leader>ev :vsplit ~/.vimrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>v
