call plug#begin(expand('~/.config/nvim/bundle'))
Plug 'digitaltoad/vim-jade'
Plug 'jansedivy/jai.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'wting/rust.vim', { 'for': 'rust' }
Plug 'idanarye/vim-dutyl', { 'for' : 'd' }
Plug 'fatih/vim-go', { 'for': 'go' }

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'bling/vim-airline'
Plug 'wellle/targets.vim'
Plug 'scrooloose/nerdtree'
Plug 'sirver/UltiSnips'
Plug 'godlygeek/tabular'
Plug 'kien/ctrlp.vim'
Plug 'ap/vim-css-color'
Plug 'calebsmith/vim-lambdify'
Plug 'miyakogi/seiya.vim'
Plug 'honza/vim-snippets'
" neo-make
" deoplete
Plug 'Shougo/deoplete.nvim'
Plug 'racer-rust/vim-racer'
Plug 'zchee/deoplete-jedi'
Plug 'benekastah/neomake'

Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'vim-scripts/Wombat'
call plug#end()

let g:neomake_tex_pdf_maker = {
            \ 'exe': 'rubber',
            \ 'args': ['-pdf', '-W=all', '%'],
            \ }

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set background=dark
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
let g:seiya_auto_enable=1
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']

let g:EclimCompletionMethod="omnifunc"

let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1

let g:racer_cmd = "/usr/bin/racer"
let $RUST_SRC_PATH = "/usr/src/rust/src"
let g:deoplete#enable_at_startup = 1

set fileencoding=utf-8

set hidden
set splitright
set undolevels=1000
set smartcase

set noswapfile backup backupdir=~/.vim/backup

" conceal cursor
aug conceal | exe 'au!' | au BufWinEnter * set concealcursor=cn | aug end
set cursorline relativenumber number
set colorcolumn=79 " all hail PEP-8
set showmatch matchtime=2
set visualbell
set list listchars=trail:•,tab:»\ |
set ts=4 sts=4 sw=4 et

noremap ; :
noremap : ;
noremap <right> :bnext<CR>
noremap <left> :bprev<CR>
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
noremap Y y$

" go back to editing the same line as you exited in a file
aug resCur
    exe 'au!'
    au BufReadPost *
\     if line("'\"") > 1 && line("'\"") <= line("$") |
\       exe "normal! g`\"" |
\     endif
aug end

aug srcVimRC | exe 'au!' | au BufWritePost init.vim source $MYVIMRC | aug end

" Open multiple lines (insert empty lines) before or after current line,
" and position cursor in the new space, with at least one blank line
" before and after the cursor.
function! OpenLines(nrlines, dir)
    let nrlines = a:nrlines < 2 ? 2 : a:nrlines
    let start = line('.') + a:dir
    call append(start, repea
    t([''], nrlines))
    if a:dir < 0 | exe 'normal! 2k' | else | exe 'normal! 2j' | endif
endfunction

" TODO : Change default
map <space> <leader>
nnoremap <Leader>o :<C-u>call OpenLines(v:count,0)<CR>S
nnoremap <Leader>O :<C-u>call OpenLines(v:count,-1)<CR>S
nnoremap <leader>ev :e $MYVIMRC

tnoremap <ESC> <C-\><C-n>

" Krack/Split lines!
nnoremap K <ESC>i<CR><ESC>mq:-1s/\s\+$//e<CR>:nohl<CR>`q
nnoremap <leader>F :s/\s\+$//e<CR>:nohl<CR>

autocmd! BufWritePost *.tex Neomake

function! Source(begin, end)
    let lines = getline(a:begin, a:end)
    for line in lines | exe line | endfor
endfunction

" eval vimscript by line or visual selection
nnoremap <silent> <leader>e :call Source(line('.'),line('.'))<CR>
vnoremap <silent> <leader>e :call Source(line('v'),line('.'))<CR>

hi TermCursor guibg=#ff0000
