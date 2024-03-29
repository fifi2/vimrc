let mapleader = ","
set history=100
set report=0
set hidden
set mouse=
set backspace=indent,eol,start
set guioptions=
set number relativenumber
set fileformats=unix,dos
if has("multi_byte")
    set encoding=utf-8
endif

if has("syntax")
    syntax on
    colorscheme default
endif

filetype plugin on

set tabstop=2 softtabstop=-1 shiftwidth=0
set expandtab
set smarttab
set autoindent
if has("smartindent")
    set smartindent
endif
set modeline

set ignorecase
set smartcase
if has("extra_search")
    set incsearch
    set hlsearch
    nnoremap <silent> <C-l> :nohlsearch<CR><C-l>
endif

set laststatus=2
if has("statusline")
    set statusline=%n
    set statusline+=\ %f
    set statusline+=%m
    set statusline+=%r
    set statusline+=\ [%{strlen(&filetype)?&filetype:'aucun'},
    \%{strlen(&fileencoding)?&fileencoding:&enc},
    \%{&fileformat}]
    set statusline+=\ %{FugitiveStatusline()}
    set statusline+=%=%l,%c%V
    set statusline+=\ %P
endif

set wildmode=longest,list,full
if has("wildmenu")
    set wildmenu
endif

if has("windows") && has("vertsplit") && has("quickfix") && has("listcmds") && has("diff")
    function! DiffOrig()
        only
        vertical new
        set buftype=nofile
        set bufhidden=delete
        r #
        0d
        windo diffthis
    endfunction

    if !exists(":DiffOrig")
        command DiffOrig call DiffOrig()
    endif
endif

function! NettoyerFichier()
    let l:save = winsaveview()
    let cursor_position = getpos(".")
    execute "%s/$//e"
    execute "%s/\\s\\+$//e"
    call setpos('.', cursor_position)
    call winrestview(l:save)
endfunction

if !exists(":NettoyerFichier")
    command NettoyerFichier call NettoyerFichier()
endif

nmap <F2> :wall<Bar>:mksession! $HOME/session_
nmap <F3> :source $HOME/session_

if has("modify_fname")
    map <Leader>cd :cd <C-R>=expand("%:p:h")<CR><CR>
endif

map <Leader>rm :echo delete(@%) <Bar> bwipeout!<CR>

function! s:Bufgrep(param)
    call setloclist(winnr(), [])
    bufdo silent lvimgrepadd /a:param/gj %
endfun
command! -nargs=1 Bufgrep call s:Bufgrep(<q-args>)

nmap <Down> :cnext<CR>
nmap <Up> :cprevious<CR>
nmap <Left> :cfirst<CR>
nmap <Right> :clast<CR>

" Send visual selection to system clipboard from Terminal
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" CtrlP
let g:ctrlp_max_depth = 500
let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\(node_modules\|\.git\/\|\.idea\)'

" Fugitive
cabbrev git Git

" Gtd params and map
let g:gtd#cache = 1
let g:gtd#default_action = 'inbox'
let g:gtd#default_context = 'work'
let g:gtd#dir = '~/notes'
let g:gtd#review = [
	\ '!inbox',
	\ '!todo',
	\ '!waiting',
	\ '!someday'
	\ ]
let g:gtd#folding = 1
nmap <Leader>gd <Plug>GtdDisplay
nmap <Leader>gf <Plug>GtdFiles
nmap <Leader>ge <Plug>GtdExplore
nmap <Leader>gn <Plug>GtdNew
vmap <Leader>gn <Plug>GtdNew

