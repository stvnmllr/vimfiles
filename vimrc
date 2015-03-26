set nocompatible 

set guifont=Consolas:h14:cANSI
set ruler
set autoindent
set ts=4
set backspace=2
set shiftwidth=4
set ignorecase
set smartcase
set incsearch
set gdefault
set hidden
set number
set hlsearch
colorscheme zenburn 
set viminfo^=%

execute pathogen#infect()
syntax on
filetype plugin indent on

nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
vnoremap . :norm.<CR>
inoremap ht <ESC>
imap <M-Space> <Esc>
nmap <F1> :w<CR>
vmap <F1> <Esc><c-s>gv
imap <F1> <Esc><c-s>
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>
nmap <C-Tab> :tabnext<CR>
map <F2> :NERDTreeToggle<CR>
no <up> <Nop>
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
vmap <F4> "+y 
map <C-c> "+y

" Bubble multiple lines
vmap <A-k> [egv
vmap <A-j> ]egv
" Bubble single lines
nmap <A-k> [e
nmap <A-j> ]e

let mapleader = ","
nmap <leader>l :set list!<CR>
nmap <leader>r :NERDTreeFind<CR>
nmap <leader>p viw"+p
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
" nnoremap <TAB> :exec "normal i".nr2char(getchar())."\e"<CR>
" nnoremap <TAB> :exec "normal a".nr2char(getchar())."\e"<CR>

vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

