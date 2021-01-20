"==========My Init.vim==========
"==========Variables==========
syntax enable
set nocompatible
set nu
set smartindent
set noerrorbells
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set noshowmode
set number relativenumber
set splitright
set updatetime=1000
set clipboard+=unnamedplus
set wildmenu
set hidden

"==========Plugins==========
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-utils/vim-man'
Plugin 'junegunn/goyo.vim'
Plugin 'mbbill/undotree'
Plugin 'dracula/vim',{'name':'dracula'}
Plugin 'itchyny/lightline.vim'
Plugin 'hiroakis/cyberspace.vim'
Plugin 'ap/vim-css-color'
Plugin 'vifm/vifm.vim'
Plugin 'Mizux/vim-colorschemes'
Plugin 'jsnal/vim-serape', {'tag': 'v0.2.2' }
call vundle#end()
filetype plugin indent on

"==========Colors and lightline==========
colorscheme serape

set laststatus=2
let g:lightline = {
			\ 'colorscheme':'dracula',
			\}

let mapleader = " "

"==========Window and buffer management==========
nnoremap <space>h :wincmd h<CR>
nnoremap <space>j :wincmd j<CR>
nnoremap <space>k :wincmd k<CR>
nnoremap <space>l :wincmd l<CR>
nnoremap <space>u :UndotreeShow<CR>
nnoremap <space>v :VsplitVifm<CR>
nnoremap <space>c :wincmd c<CR>
nnoremap <space>f :bn<CR>
nnoremap <space>g :bp<CR>
nnoremap <space><space> /<++><CR>ca<
nnoremap <space>d :bd!<CR>
nnoremap <space>o :only!<CR>
nnoremap <tab> :b#<CR>
nnoremap <space>w :w<CR>
nnoremap <space>q :q!<CR>
nnoremap <space>b :ls<CR>
nnoremap <space>; :Vifm<CR>
nnoremap <space>1 :b1<CR>
nnoremap <space>2 :b2<CR>
nnoremap <space>3 :b3<CR>
nnoremap <space>4 :b4<CR>

"==========Registers==========
nmap dD "_dd

"==========Movements==========
nmap <down> ddp
nmap <right> dwea<space><ESC>pxb
nmap <left> dwbPa<space><ESC>b
nmap <up> ddkP
imap <down> <Nop>
imap <right> <Nop>
imap <left> <Nop>
imap <up>  <Nop>
vmap <down> <Nop>
vmap <right> <Nop>
vmap <left> <Nop>
vmap <up> <Nop>
nmap <CR> i<CR><ESC>k
nmap E gE
imap jj <ESC>
imap jk <ESC>
imap kj <ESC>
nnoremap gg mjgg
nnoremap L mj$
nnoremap I mjI
nnoremap / mj/
nmap g{ f{a
nmap g} F}i

"==========Make some room==========
nmap go o<ESC>k
nmap gO O<ESC>j

"==========Center the screen==========
nnoremap G mjGzz
nmap n nzz
nmap N Nzz
nnoremap 'j 'jzz
nnoremap 'k 'kzz
nnoremap K mjHzz
nnoremap J mjLzz
autocmd InsertEnter * norm zz

"==========Autocommands==========
autocmd BufWritePre * %s/\s\+$//e

"==========C++==========
autocmd BufWritePre *.cpp,*.h,*.html,*.css :normal gg=G'j<CR>
autocmd BufWritePre *.cpp %s/}$/};/e
autocmd BufWritePre *.cpp,*.h :g/};\n[double|int|vector|void]/normal o
autocmd FileType c++,cpp imap <buffer> \{ {<CR>};<ESC>O

"==========Latex==========
autocmd FileType tex,plaintex nmap <silent><buffer> ,r :-1read ~/Documents/Personal/Latex/Templates/relazione.tex<CR>
autocmd FileType tex,plaintex nmap <silent><buffer> ,a :-1read ~/Documents/Personal/Latex/Templates/template.tex<CR>
autocmd FileType tex,plaintex imap <silent><buffer> ,e <ESC>:-1read ~/Documents/Personal/Latex/Templates/equation.tex<CR>
autocmd FileType tex,plaintex imap <silent><buffer> ,d <ESC>:-1read ~/Documents/Personal/Latex/Templates/definition.tex<CR>
autocmd FileType tex,plaintex imap <silent><buffer> ,t <ESC>:-1read ~/Documents/Personal/Latex/Templates/theorem.tex<CR>
autocmd FileType tex,plaintex imap <silent><buffer> ,p <ESC>:-1read ~/Documents/Personal/Latex/Templates/deriv_parziale.tex<CR>
autocmd FileType tex,plaintex nnoremap <buffer><space>s :w<CR> :!pdflatex %<CR><CR>
autocmd FileType tex,plaintex nnoremap <buffer><space>S :w<CR> :!pdflatex %<CR>
autocmd FileType tex,plaintex nmap <buffer><space>p :!zathura %:r.pdf & disown<CR>
autocmd FileType tex,plaintex imap <buffer> aa \`{a}
autocmd FileType tex,plaintex imap <buffer> ee \`{e}
autocmd FileType tex,plaintex imap <buffer> oo \`{o}
autocmd FileType tex,plaintex imap <buffer> ii \`{i}
autocmd FileType tex,plaintex imap <buffer> uu \`{u}
autocmd FileType tex,plaintex imap <buffer> EE \`{E}

"==========Suckless==========
autocmd BufWritePre config.h,config.def.h :cd "%:p:h"<CR> :!sudo make clean install<CR>

"==========Sessioni==========
autocmd BufNewFile,BufRead [0-9][0-9].txt nmap <silent><buffer> ,t :-1read ~/Documents/University/Sessione_Invernale/template.txt<CR>

"==========Netrw==========
"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_winsize = 20
"let g:netrw_browse_split = 3

"Disable Netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

"==========Vifm==========
let g:vifm_replace_netrw = 1
let g:vifm_replace_netrw_cmd = "Vifm"
