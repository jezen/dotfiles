" Jezen Thomas’ .vimrc
"   jezen@jezenthomas.com
"   jezenthomas.com

" Thanks to:
"   - Steve Losh
"   - Gary Bernhardt
"   - Amir Salihefendic
"   - Vincent Driessen
"   - Benjamin Reitzammer

" Init & Vundle ------------------------------------------------------------ {{{
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

" Gary Bernhardt’s colour scheme
Plug 'quanganhdo/grb256'
set t_Co=256
colorscheme grb256

" Pimp my editor
Plug 'https://github.com/mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'https://github.com/chrisbra/unicode.vim'
Plug 'w0rp/ale'
Plug 'godlygeek/tabular'
Plug 'itchyny/calendar.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

" Language specific
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'pbrisbin/vim-syntax-shakespeare'
Plug 'pangloss/vim-javascript'
Plug 'elmcast/elm-vim'

call plug#end()
filetype plugin indent on
" }}}
" Basic config ------------------------------------------------------------- {{{
" This makes RVM work inside Vim.
set shell=bash
set lazyredraw
set autoread
set hidden
set noesckeys
"set cryptmethod=blowfish2 " https://dgl.cx/2014/10/vim-blowfish
set exrc " Enable use of project-specific .vimrc
set secure " Only run autocommands owned by me
" }}}
" Calendar ----------------------------------------------------------------- {{{
" https://github.com/itchyny/calendar.vim
let g:calendar_google_calendar=1
let g:calendar_date_month_name=1
let g:calendar_week_number=1
" }}}
" Linting ------------------------------------------------------------------ {{{
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
" }}}
" UI ----------------------------------------------------------------------- {{{
syntax on                         " Enable syntax highlighting
set ruler                         " Show current position in status bar
set synmaxcol=80                  " Don’t highlight lines longer than 80 chars
set wrap                          " Soft-wrap long lines
set linebreak
set showbreak=↪                   " Prefix linebreaks with this fancy arrow
set scrolloff=5                   " Keep at least 5 lines above/below
set title                         " Change terminal title
set showmode                      " Always show current mode
set laststatus=2                  " Make sure airline isn’t hidden
set shortmess=atI                 " Hide intro message
set showcmd                       " Show command as it’s being typed
set list                          " Show invisible characters
set noerrorbells                  " Disable bells
set wildmenu                      " Enhance command-line completion

" Default netrw to tree mode
let g:netrw_liststyle=3

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" }}}
" Editing ------------------------------------------------------------------ {{{
set clipboard=unnamed             " Use the system clipboard
set et                            " Pressing TAB creates spaces instead
set tabstop=2
set shiftwidth=2
set backspace=indent,eol,start    " Allow backspace in insert mode
set lcs=tab:▸\ ,extends:❯,precedes:❮,nbsp:.,trail:·,eol:¬
set nobackup                      " Disable backups
set nowb                          " Disable write backups
set noswapfile                    " Disable swap files
set completeopt-=preview          " Disable scratch preview buffer
set ttyfast
set encoding=utf-8 nobomb         " Use UTF-8 without BOM
set nojoinspaces                  " Don’t double space after join
set splitbelow                    " I always thought vim opened splits backwards
set splitright
set diffopt+=vertical             " Split vertically when doing Gdiff
" }}}
" Convenience mappings ----------------------------------------------------- {{{

" Please, do not use comma for leader. You need the comma for moving to a
" previous match from a linewise character search.
let mapleader="\<space>"

" Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Since I remapped H and L to move to the beginning and end of the current
" line respectively, something in my subconscious made me start using K to
" move to the top of the buffer. By default, K will open the man page for the
" term under the cursor, which is completely useless to me.
nnoremap K <nop>

" Fast saving
nmap <leader>s :w!<cr>

" Save as super user
noremap <leader>S :w !sudo tee % > /dev/null<CR>

" Fast quit
nmap <leader>q :q<cr>

" Jump to first character or column
noremap <silent> H :call FirstCharOrFirstCol()<cr>
" Jump to end of line
noremap L $

function! FirstCharOrFirstCol()
  let current_col = virtcol('.')
  normal ^
  let first_char = virtcol('.')
  if current_col <= first_char
    normal 0
  endif
endfunction

" Toggle alternate buffer
nnoremap <leader><leader> <c-^>

iabbrev ldis ಠ_ಠ
iabbrev lsir ಠ_ರೃ
iabbrev lhap ツ
iabbrev fliptable （╯°□°）╯ ┻━┻
iabbrev *shrug* ¯\_(ツ)_/¯
iabbrev herewego ᕕ( ᐛ )ᕗ
iabbrev dealwithit (⌐■_■)
iabbrev yeahdawg 
      \<cr>▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
      \<cr>░░░░░ ░░░░▀█▄▀▄▀██████░▀█▄▀▄▀████▀
      \<cr>░░░░ ░░░░░░░▀█▄█▄███▀░░░▀██▄█▄█▀

nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :split<cr>
" }}}
" Searching ---------------------------------------------------------------- {{{
set showmatch                     " Show matching bracket when under cursor
set hlsearch                      " Highlight search results
set ignorecase                    " Ignore case when searching
set smartcase                     " Case-sensitive if pattern includes uppercase
set incsearch                     " Highlight dynamically while typing

" Clear the higlighted search results
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Keep search matches in middle of window
nnoremap n nzzzv
nnoremap N Nzzzv

set wildignore+=*.jpg,*.png,*.gif,*.aux                            " binary images

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>a :Ag<CR>
" }}}
" Folding ------------------------------------------------------------------ {{{
set foldlevelstart=0
set foldmethod=marker " Use three curly braces
" Toggle folds with minus
nnoremap - za
vnoremap - za

" Focus current fold
nnoremap <leader>z zMzvzz

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()
" }}}
" Automatic commands ------------------------------------------------------- {{{
if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  au BufNewFile,BufRead *.json setfiletype json syntax=javascript
  au BufNewFile,BufRead *.cap setfiletype cap syntax=ruby
  au BufNewFile,BufRead *.thor set filetype=ruby
  au BufNewFile,BufRead *.txt call FoldParagraphs()
  au BufNewFile,BufRead *.hs set formatprg=xargs\ pointfree
  au BufLeave           *.hs set formatprg=
  " https://codeyarns.com/2015/02/02/cannot-close-buffer-of-netrw-in-vim/
  au FileType netrw setl bufhidden=wipe
  " Automatically open quickfix window when calling :make, or close the
  " quickfix window if there are no errors to report
  au QuickFixCmdPost [^l]* nested cwindow
  au QuickFixCmdPost    l* nested lwindow
endif

function! FoldParagraphs()
  set foldmethod=expr
  set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
endfunction

" Make sure Vim returns to the same line when reopening a file
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END
" }}}
" Haskell ------------------------------------------------------------------ {{{
let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a: :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>
vmap a< :Tabularize /<-<CR>
vmap a( :Tabularize /(<CR>
vmap a\| :Tabularize /\|<CR>
vmap a. :Tabularize /\.<CR>
"}}}
" Elm ---------------------------------------------------------------------- {{{
let g:elm_format_autosave = 0
"}}}
