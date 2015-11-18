set nocompatible " Who cares about vi?
" this makes vim suddenly convert stuff it shouldn't.
" scriptencoding utf-8
set fileencoding=utf-8
set encoding=utf-8 " Requried for powerline fonts!

filetype off
set rtp+=~/vimfiles/bundle/vundle/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'digitaltoad/vim-jade'
Plugin 'bling/vim-airline'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'garbas/vim-snipmate'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Valloric/YouCompleteMe'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-repeat'
Plugin 'morhetz/gruvbox'
Plugin 'kien/ctrlp.vim'

call vundle#end()

let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1

let g:airline#extensions#tabline#enabled = 1

" Enables detection, plugin and indentation
filetype plugin indent on
" enable syntax coloring
syntax enable
" make buffers behave like tabs
set hidden

" no swap files!
set noswapfile
" but enable backup
set backup
set backupdir=~/.vim/backup

" only draw when needed!
set lazyredraw
" auto complete for :e
set wildmenu

set ruler
set cursorline     " hightlight current line
set relativenumber " shows relative line numbers
set number         " cool line numbers at the left
set colorcolumn=79 " all hail PEP-8
set laststatus=2   " this is for airline
set showcmd

" matching parenthesis
set showmatch matchtime=2

" yea bb
set backspace=2
" for the autoindenting function
set tabstop=4 softtabstop=4 shiftwidth=4
" go go spaces
set expandtab copyindent smarttab
" search while typing
" highlight searches
set incsearch hlsearch
" smart ignore case
set smartcase

" list chars!
set list listchars=trail:•,tab:»\ 

set undolevels=1000
set history=700

" stupid beeps
set visualbell noerrorbells

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
nnoremap <leader>ev :e $HOME\Documents\dotfiles\_vimrc
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
