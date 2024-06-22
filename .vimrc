execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype plugin indent on

if has('termguicolors')
    set termguicolors
endif

let mapleader=","
let maplocalleader="'"

" Sets the terminal window's scroolback buffer size
let g:terminal_scrollback_buffer_size = 100000

" COPILOT SETTINGS
let g:copilot_no_tab_map = v:true

let g:editorconfig = v:false

let g:markdown_fenced_languages = ['python', 'bash=sh', 'cpp', 'gdscript', 'plantuml', 'rust']

set autoindent
set backspace=indent,eol,start
set binary
set colorcolumn=80
set display=uhex
set expandtab
set hlsearch
set ignorecase
set incsearch
set list
set mouse=a
set nobackup
set noshowmode
set number
set pumheight=10
set pumwidth=10
set ruler
set scrolloff=5
set shell=bash\ -i
set shiftround
set shiftwidth=4
set showcmd
set smartcase
set smartindent
set splitbelow
set splitright
set startofline
set tabpagemax=100
set tabstop=4
set undofile
set wildmenu
set wildmode=longest:full

" Line number customization
set cursorline

augroup cplusplus
    autocmd!
    autocmd FileType cpp setlocal colorcolumn=120
    autocmd FileType cpp setlocal noexpandtab
    autocmd FileType cpp nnoremap <buffer> <localleader>c I// <ESC>
augroup END
augroup godot
    autocmd!
    autocmd FileType gdscript setlocal foldlevel=99
    autocmd FileType gdscript setlocal foldmethod=expr
    autocmd FileType gdscript setlocal tabstop=4
    autocmd FileType gdscript nnoremap <buffer> <localleader>r :GodotRun<CR>
    autocmd FileType gdscript nnoremap <buffer> <localleader>t :GodotRunCurrent<CR>
    autocmd FileType gdscript nnoremap <buffer> <localleader>c I# <ESC>
augroup END
augroup markdown
    autocmd!
    autocmd FileType markdown setlocal shiftwidth=2
    autocmd FileType markdown setlocal tabstop=2
    autocmd FileType markdown onoremap <buffer> ih :<C-U>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rkvg_"<CR>
    autocmd FileType markdown onoremap <buffer> ah :<C-U>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rg_vk0"<CR>
augroup END
augroup netrw
    autocmd!
    " Open a file or go down the hierarchy
    autocmd FileType netrw nmap <buffer> l <CR>
    " Go up the hierarchy, 8th line should be ".."
    autocmd FileType netrw nmap <buffer> h 8G<CR>
    " Close preview (opened by `p`)
    autocmd FileType netrw nnoremap <buffer> P <C-W>z
augroup END
augroup plantuml
    autocmd!
    autocmd FileType plantuml setlocal shiftwidth=2
    autocmd FileType plantuml setlocal tabstop=2
augroup END
augroup proj
    autocmd!
    autocmd BufNewFile,BufRead *.proj setlocal filetype=proj
    autocmd FileType proj setlocal shiftwidth=2
    autocmd FileType proj setlocal tabstop=2
augroup END
augroup python
    autocmd!
    autocmd FileType python setlocal list
    autocmd FileType python setlocal nowrap
    autocmd FileType python nnoremap <buffer> <localleader>c I# <ESC>
augroup END
augroup robot
    autocmd!
    autocmd BufNewFile,BufRead *.robot setlocal filetype=robot
    autocmd FileType robot nnoremap <buffer> <localleader>c I# <ESC>
augroup END
augroup rust
    autocmd!
    autocmd FileType rust nnoremap <buffer> <localleader>c I// <ESC>
augroup END
augroup sh
    autocmd!
    autocmd FileType sh setlocal tabstop=2
    autocmd FileType sh setlocal shiftwidth=2
augroup END

" Insert mode mappings
inoremap jk                 <ESC>
" Remap the completion menu (used by LSPs)
inoremap <C-K>              <C-X><C-O>
" Quick convert word under the cursor to uppercase
inoremap <C-U>              <ESC>viwUea

" Normal mode mappings
nnoremap <leader>qq     :nohlsearch<CR>
"   Diagnostic Disable
nnoremap <leader>dd     :lua vim.diagnostic.hide()<CR>
"   Diagnostic Enable
nnoremap <leader>de     :lua vim.diagnostic.show()<CR>
"   Telescope mappings
"     <C-X> - open file in horizontal split
"     <C-V> - open file in vertical split
"     <C-T> - open file in new tab
"   Go to definition, using an LSP
nnoremap <leader>gd     :Telescope lsp_definitions<CR>
nnoremap <leader>gi     :Telescope lsp_implementations<CR>
nnoremap <leader>gr     :Telescope lsp_references include_current_line=true<CR>
nnoremap <leader>ff     :Telescope find_files<CR>
nnoremap <leader>fg     :Telescope live_grep<CR>
"   As in "find symbol"
nnoremap <leader>fs     :Telescope lsp_document_symbols<CR>
"   Open file under the cursor, move split to the right
nnoremap <leader>wf     <C-W>f<C-W>L
"   Copies the path of the current file to the clipboard
nnoremap <leader>pwd    :let @+=expand("%:p")<CR>:echo expand("%:p")<CR>
"   Trim trailing whitespace
nnoremap <leader>tr     :%s/\s\+$//e<CR>
nnoremap <leader>ev     :vsplit ~/.vimrc<CR>
nnoremap <leader>el     :vsplit ~/.config/nvim/lua/init.lua<CR>

" Visual mode mappings
"   Wrap selection in apostrophe marks
vnoremap <leader>"      <ESC>`<i"<ESC>`>a"<ESC>v

" Everything color related
"   Theme
set background=dark
colorscheme melange

"   Highlight trailing whitespaces across all files
match TrailingWhitespace /\s\+$/
highlight link TrailingWhitespace   ErrorMsg

"   lightline
let g:lightline = {
\   'colorscheme': 'melange',
\   'active': {
\       'left': [
\           [ 'mode', 'paste' ],
\           [ 'readonly', 'filename', 'modified' ]
\       ]
\   },
\   'component': {
\       'lineinfo': '%3l:%-2c%-2V',
\   },
\ }
