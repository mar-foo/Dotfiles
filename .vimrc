filetype off

set rtp+=~/.vim/bundle/Vundle.vim
syntax on 
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

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-utils/vim-man'
Plugin 'junegunn/goyo.vim'
Plugin 'lyuts/vim-rtags'
Plugin 'kien/ctrlp.vim.git'
Plugin 'mbbill/undotree'
Plugin 'bignimbus/pop-punk.vim'
Plugin 'preservim/nerdtree'
Plugin 'dracula/vim',{'name':'dracula'}
Plugin 'itchyny/lightline.vim'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'ghifarit53/tokyonight-vim'
Plugin 'hiroakis/cyberspace.vim'
Plugin 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plugin 'ap/vim-css-color'
Plugin 'ycm-core/YouCompleteMe'

call vundle#end()

filetype plugin indent on
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
colorscheme cyberspace 

set laststatus=2
let g:lightline = {
	\ 'colorscheme':'darcula',
	\}

let mapleader = " "

let g:ctrlp_use_caching = 0

let g:livepreview_previewer = 'zathura'

set viminfofile='$HOME/.vim/.viminfo'

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>v :wincmd v<CR> :NERDTreeToggle<CR>
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>
nnoremap <leader>g :Goyo<CR>
nnoremap <leader>s :LLPStartPreview<CR>

:py3 pass
