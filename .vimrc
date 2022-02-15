execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype plugin indent on

if has('termguicolors')
    set termguicolors
endif

set background=dark
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_ui_contrast = 'high'
colorscheme gruvbox-material

" lightline
let g:lightline = {'colorscheme' : 'gruvbox_material'}

" Robot syntax highlight
highlight link robotSETUP           Include
highlight link robotTEARDOWN        Include
highlight link robotTEMPLATE        Include
highlight link robotARGUMENTS       Include
highlight link robotTAGS            Include
highlight link robotKEYWORD         Function
highlight link robotASSIGN          Type
highlight link robotFOR             Statement
highlight link robotEND             Statement
highlight link robotCOMMENT         Comment
highlight link robotCONTINUATION    Special

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

let mapleader="-"
let maplocalleader=","

augroup python
    autocmd!
    autocmd FileType python setlocal nowrap
    autocmd FileType python setlocal list
    autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
    autocmd BufWritePre *.py :%s/\s\+$//e
augroup END
augroup robot
    autocmd!
    autocmd BufNewFile,BufRead *.robot set filetype=robot
    autocmd FileType robot nnoremap <buffer> <localleader>c I# <esc>
    autocmd BufWritePre *.robot :%s/\s\+$//e
augroup cplusplus
    autocmd!
    autocmd FileType cpp set noexpandtab
    autocmd FileType cpp nnoremap <buffer> <localleader>c I//<esc>
    autocmd BufWritePre *.cpp,*.h,*.hpp :%s/\s\+$//e
augroup END
augroup html
    autocmd!
    " Fold tag content
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END
augroup markdown
    autocmd!
    autocmd FileType markdown onoremap <buffer> ih :<c-u>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rkvg_"<cr>
	autocmd FileType markdown onoremap <buffer> ah :<c-u>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rg_vk0"<cr>
augroup END

" Insert mode mappings
inoremap <leader><c-u> <esc>viwU<esc>ea
inoremap jk <esc>

" Normal mode mappings
nnoremap <leader><c-u>  viwU<esc>e
nnoremap <leader>ev     :vsplit ~/.vimrc<CR>
nnoremap <leader>sv     :source $MYVIMRC<CR>
" Copies the path of the current file to the clipboard
nnoremap <leader>pwd    :let @+=expand("%:p")<CR>
" Trim trailing whitespace
nnoremap <leader>tr     :%s/\s\+$//e<CR>

" Visual mode mappings
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>v
