execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype plugin indent on

if has('termguicolors')
    set termguicolors
endif

let mapleader="-"
let maplocalleader=","

" Sets the terminal window's scroolback buffer size
let g:terminal_scrollback_buffer_size = 100000

" COPILOT SETTINGS
let g:copilot_no_tab_map = v:true

let g:editorconfig = v:false

let g:markdown_fenced_languages = ['python', 'bash=sh', 'cpp', 'gdscript', 'plantuml', 'rust']

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
set smartcase
set backspace=indent,eol,start
set smartindent
set autoindent
set hlsearch
set incsearch
set tabpagemax=100
set wildmode=longest:full
set wildmenu
set colorcolumn=80
set splitbelow
set splitright
set startofline
set scrolloff=5
set noshowmode
set undofile
set clipboard+=unnamedplus
set pumwidth=10
set pumheight=10

" Line number customization
set cursorline
highlight clear CursorLine
highlight CursorLineNr guifg=#fb4934 guibg=#45403d

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

" Highlight trailing whitespaces across all files
highlight link TrailingWhitespace   ErrorFloat
match TrailingWhitespace /\s\+$/

augroup python
    autocmd!
    autocmd FileType python setlocal nowrap
    autocmd FileType python setlocal list
    autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
augroup END
augroup cplusplus
    autocmd!
    autocmd FileType cpp setlocal noexpandtab
    autocmd FileType cpp setlocal colorcolumn=120
    autocmd FileType cpp nnoremap <buffer> <localleader>c I// <esc>
augroup END
augroup rust
    autocmd!
    autocmd FileType rust nnoremap <buffer> <localleader>c I// <esc>
augroup END
augroup markdown
    autocmd!
    autocmd FileType markdown setlocal shiftwidth=2
    autocmd FileType markdown setlocal tabstop=2
    autocmd FileType markdown onoremap <buffer> ih :<c-u>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rkvg_"<cr>
    autocmd FileType markdown onoremap <buffer> ah :<c-u>execute "normal! ?^\\(==\\+\\\\|--\\+\\)$\r:nohlsearch\rg_vk0"<cr>
augroup END
augroup netrw
    autocmd!
    " Open a file or go down the hierarchy
    autocmd FileType netrw nmap <buffer> l <CR>
    " Go up the hierarchy, 8th line should be ".."
    autocmd FileType netrw nmap <buffer> h 8G<CR>
    " Close preview (opened by `p`)
    autocmd FileType netrw nnoremap <buffer> P <C-w>z
augroup END
augroup godot
    autocmd!
    autocmd FileType gdscript setlocal foldmethod=expr
    autocmd FileType gdscript setlocal tabstop=4
    autocmd FileType gdscript setlocal foldlevel=99
    autocmd FileType gdscript nnoremap <buffer> <localleader>r :GodotRun<CR>
    autocmd FileType gdscript nnoremap <buffer> <localleader>t :GodotRunCurrent<CR>
    autocmd FileType gdscript nnoremap <buffer> <localleader>c I# <esc>
augroup END
augroup plantuml
    autocmd!
    autocmd FileType plantuml setlocal tabstop=2
    autocmd FileType plantuml setlocal shiftwidth=2
augroup END
augroup robot
    autocmd!
    autocmd BufNewFile,BufRead *.robot setlocal filetype=robot
    autocmd FileType robot nnoremap <buffer> <localleader>c I# <esc>
augroup END
augroup proj
    autocmd!
    autocmd BufNewFile,BufRead *.proj setlocal filetype=proj
    autocmd FileType proj setlocal tabstop=2
    autocmd FileType proj setlocal shiftwidth=2
augroup END

" Insert mode mappings
inoremap jk                             <esc>
" Remap the completion menu (used by LSPs)
inoremap <C-K>                          <C-X><C-O>

" Normal mode mappings
nnoremap <leader>qq         :nohlsearch<CR>
"   Telescope mappings
"     <C-x> - open file in horizontal split
"     <C-v> - open file in vertical split
"     <C-t> - open file in new tab
"   Go to definition, using an LSP
nnoremap <leader>gd         :Telescope lsp_definitions<CR>
nnoremap <leader>gi         :Telescope lsp_implementations<CR>
nnoremap <leader>gr         :Telescope lsp_references include_current_line=true<CR>
nnoremap <leader>ff         :Telescope find_files<CR>
nnoremap <leader>fg         :Telescope live_grep<CR>
"   As in "find symbol"
nnoremap <leader>fs         :Telescope lsp_document_symbols<CR>
"   Open file under the cursor, move split to the right
nnoremap <leader>wf         <c-w>f<c-w>L
"   Copies the path of the current file to the clipboard
nnoremap <leader>pwd        :let @+=expand("%:p")<CR>:echo expand("%:p")<CR>
"   Trim trailing whitespace
nnoremap <leader>tr         :%s/\s\+$//e<CR>
nnoremap <leader>ev         :vsplit ~/.vimrc<CR>
nnoremap <leader>el         :vsplit ~/.config/nvim/lua/init.lua<CR>

" Visual mode mappings
"   Wrap selection in apostrophe marks
vnoremap <leader>"          <esc>`<i"<esc>`>a"<esc>v

" theme
set background=dark
colorscheme gruvbox

" lightline
let g:lightline = {
\   'colorscheme': 'gruvbox',
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
