set nocompatible " Who cares about vi?
set fileencoding=utf-8
set encoding=utf-8 " Requried for powerline fonts!

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'digitaltoad/vim-jade'
Plug 'bling/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'tomtom/tcomment_vim'
Plug 'Valloric/YouCompleteMe'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
Plug 'morhetz/gruvbox'
Plug 'kien/ctrlp.vim'
Plug 'ap/vim-css-color'
Plug 'haya14busa/incsearch.vim'
Plug 'tomasr/molokai'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'calebsmith/vim-lambdify'

call plug#end()

let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_enable_on_vim_startup=1

set concealcursor=cn

let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1

let g:airline#extensions#tabline#enabled = 1

set hidden
set noswapfile backup backupdir=~/.vim/backup

set cursorline relativenumber number
set colorcolumn=79 " all hail PEP-8
set showcmd

" matching parenthesis
set showmatch matchtime=2

set ts=4 sts=4 sw=4 et
set copyindent smarttab
set hlsearch smartcase

" list chars!
set list listchars=trail:•,tab:»\ 

" stupid beeps
set visualbell

" type commands using ;
noremap ; :
noremap : ;

" using vim the hard way
noremap <right> :bnext<CR>
noremap <left> :bprev<CR>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
inoremap <esc> <nop>
" change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>
" move visually in wrapped lines
noremap j gj
noremap k gk
" get out of the insert mode easily!
inoremap jk <ESC>
inoremap kj <ESC>
" This makes sense, doesn't it? :h Y
noremap Y y$

" go back to editing the same line as you exited in a file
function! ResCur()
    if line("'\"") <= line("$")
        normal! g'"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

augroup sourceVimRC
    autocmd!
    autocmd BufWritePost _vimrc source $MYVIMRC
augroup END

" Open multiple lines (insert empty lines) before or after current line,
" and position cursor in the new space, with at least one blank line
" before and after the cursor.
function! OpenLines(nrlines, dir)
    let nrlines = a:nrlines < 2 ? 2 : a:nrlines
    let start = line('.') + a:dir
    call append(start, repeat([''], nrlines))
    if a:dir < 0
        normal! 2k
    else
        normal! 2j
    endif
endfunction

map <space> <leader>
" Mappings to open multiple lines and enter insert mode.
nnoremap <Leader>o :<C-u>call OpenLines(v:count, 0)<CR>S
nnoremap <Leader>O :<C-u>call OpenLines(v:count, -1)<CR>S
" Shortcut to edit this nice file
nnoremap <leader>ev :e ~/.vimrc
nnoremap <leader>; mqA;<ESC>`q
" No more search highlighting pls
nnoremap <leader>h :nohl<CR>

function! Preserve(command) "{{{
    " preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    execute a:command
    " clean up: restore previous search history, and cursor position
    call cursor(l, c)
endfunction "}}}

function! StripTrailingWhitespace() "{{{
    call Preserve("%s/\\s\\+$//e")
endfunction "}}}

" Krack/Split lines!
nnoremap <leader>k <ESC>i<CR><ESC>:call StripTrailingWhitespace()<CR>
" formatting shortcuts
nnoremap <leader>fef :call Preserve("normal gg=G")<CR>
nnoremap <leader>f$ :call StripTrailingWhitespace()<CR>

function! Source(begin, end) "{{{
    let lines = getline(a:begin, a:end)
    for line in lines
        execute line
    endfor
endfunction "}}}

" eval vimscript by line or visual selection
nnoremap <silent> <leader>e :call Source(line('.'), line('.'))<CR>
vnoremap <silent> <leader>e :call Source(line('v'), line('.'))<CR>
" Normal paste
noremap <leader>p "*p
" ls (aka dir)
nnoremap <leader>l :!dir<CR>

set background=dark
colorscheme gruvbox
set guifont=Fantasque_Sans_Mono:h12
let g:airline_powerline_fonts = 1

" mode aware cursors
set gcr=a:block
set gcr+=o:hor50-Cursor
set gcr+=n:Cursor
set gcr+=i-ci-sm:InsertCursor
set gcr+=r-cr:ReplaceCursor-hor20
set gcr+=c:CommandCursor
set gcr+=v-ve:VisualCursor
set gcr+=a:blinkon0

hi InsertCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=37  guibg=#2aa198
hi VisualCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=125 guibg=#d33682
hi ReplaceCursor ctermfg=15 guifg=#fdf6e3 ctermbg=65  guibg=#dc322f
hi CommandCursor ctermfg=15 guifg=#fdf6e3 ctermbg=166 guibg=#cb4b16

let g:syntastic_d_include_dirs = add(map(filter(glob('~/AppData/Roaming/dub/packages/*', 1, 1), 'isdirectory(v:val)'), 'isdirectory(v:val . "/source") ? v:val . "/source" : v:val'), './source')
