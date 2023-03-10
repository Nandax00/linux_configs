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
	\ 'colorscheme' : 'gruvbox_material',
	\ 'component': {
	\   'lineinfo': '%3l:%-2c%-2V'
	\ },
\ }

" YouCompleteMe
let g:ycm_goto_buffer_command = "split"

" PYMODE SETTINGS
let g:pymode = 1
let g:pymode_options = 1
let g:pymode_options_colorcolumn = 1
" Sets the terminal window's scroolback buffer size
let g:terminal_scrollback_buffer_size = 100000

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
set smartcase
set backspace=indent,eol,start
set autoindent
set hlsearch
set incsearch
set tabpagemax=100
set wildmode=longest:full
set wildmenu
set colorcolumn=80
set splitbelow
set startofline
set scrolloff=5
set noshowmode
set undofile

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
    autocmd BufWritePre *.py :%s/\s\+$//e
augroup END
augroup robot
    autocmd!
    autocmd BufNewFile,BufRead *.robot setlocal filetype=robot
    autocmd FileType robot nnoremap <buffer> <localleader>c I# <esc>
    autocmd BufWritePre *.robot :%s/\s\+$//e
augroup cplusplus
    autocmd!
    autocmd FileType cpp setlocal noexpandtab
    autocmd FileType cpp setlocal colorcolumn=120
    autocmd FileType cpp nnoremap <buffer> <localleader>c I//<esc>
    " autocmd BufWritePre *.cpp,*.h,*.hpp :%s/\s\+$//e
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
    " Open a file from netrw
    autocmd FileType netrw nnoremap <buffer> l <CR>
    " Open a file from netrw and close netrw
    autocmd FileType netrw nmap <buffer> L <CR>:Lexplore<CR>
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

" Insert mode mappings
"   Switch word under cursor to uppercase
inoremap <leader><c-u>      <esc>viwU<esc>ea
inoremap jk                 <esc>

" Normal mode mappings
nnoremap <leader>qq         :nohlsearch<CR>
nnoremap <leader>gd         :rightbelow vertical YcmCompleter GoTo<CR>
nnoremap <leader>gD         :tab YcmCompleter GoTo<CR>
nnoremap <leader>gr         :YcmCompleter GoToReferences<CR>
nnoremap <leader>pd         :YcmDiags<CR><C-W>k
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
