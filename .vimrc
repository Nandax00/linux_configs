execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype plugin indent on

if has('termguicolors')
    set termguicolors
endif

let mapleader="-"
let maplocalleader=","

" netrw
let g:netrw_banner = 0

" theme
set background=dark
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_ui_contrast = 'high'
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_sign_column_background = 'grey'
let g:gruvbox_material_statusline_style = 'original'
colorscheme gruvbox-material

" lightline
let g:lightline = {
\   'colorscheme' : 'gruvbox_material',
\   'active': {
\       'left': [
\           [ 'mode', 'paste' ],
\           [ 'readonly', 'filename', 'modified', ]
\       ]
\   },
\   'component': {
\       'lineinfo': '%3l:%-2c%-2V',
\   },
\ }

" YouCompleteMe
let g:ycm_goto_buffer_command = "split"

" Sets the terminal window's scroolback buffer size
let g:terminal_scrollback_buffer_size = 100000

" COPILOT SETTINGS
let g:copilot_no_tab_map = v:true

let g:editorconfig = v:false

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
augroup robot
    autocmd!
    autocmd BufNewFile,BufRead *.robot setlocal filetype=robot
    autocmd FileType robot nnoremap <buffer> <localleader>c I# <esc>
augroup END
augroup cplusplus
    autocmd!
    autocmd FileType cpp setlocal noexpandtab
    autocmd FileType cpp setlocal colorcolumn=120
    autocmd FileType cpp nnoremap <buffer> <localleader>c I//<esc>
augroup END
augroup html
    autocmd!
    " Fold tag content
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
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
    " Go up the hierarchy
    autocmd FileType netrw nmap <buffer> h gg<CR>
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

" Insert mode mappings
"   Switch word under cursor to uppercase
inoremap <c-u>                          <esc>viwU<esc>ea
inoremap jk                             <esc>
inoremap <silent><script><expr> <c-l>   copilot#Accept("\<CR>")

" Normal mode mappings
nnoremap <leader>qq         :nohlsearch<CR>
nnoremap <leader>gd         <Plug>(coc-definition)
" FIXME: This is not working
nnoremap <leader>gD         :tab <Plug>(coc-definition)<CR>
nnoremap <leader>gi         <Plug>(coc-implementation)
nnoremap <leader>gr         <Plug>(coc-references)
"   As in "next diagnostic"
nnoremap <leader>nd         <Plug>(coc-diagnostic-next)
nnoremap <leader>nD         <Plug>(coc-diagnostic-prev)
nnoremap <leader>cc         :CocListCancel<CR>
"   Switch word under cursor to uppercase
nnoremap <leader><c-u>      viwU<esc>e
"   Open file under the cursor, move split to the right
nnoremap <leader>wf         <c-w>f<c-w>L
nnoremap <leader>ev         :vsplit ~/.vimrc<CR>
nnoremap <leader>sv         :source $MYVIMRC<CR>
"   Copies the path of the current file to the clipboard
nnoremap <leader>pwd        :let @+=expand("%:p")<CR>:echo expand("%:p")<CR>
"   Trim trailing whitespace
nnoremap <leader>tr         :%s/\s\+$//e<CR>
"   Browse working directory
nnoremap <leader>bw         :Lexplore<CR>
"   Browse current directory of the file
nnoremap <leader>bc         :Lexplore %:p:h<CR>

" Visual mode mappings
"   Wrap selection in apostrophe marks
vnoremap <leader>"          <esc>`<i"<esc>`>a"<esc>v
