" Enable filetype plugins
set nocompatible
filetype off

""""""""""""""""""""""
" Plugins
"""""""""""""""""""""" 
call plug#begin('~/config/nvim/plugged')

" adds :Git or :G functionality for git commmands
Plug 'tpope/vim-fugitive'

" adds fuzzy matching search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" adds syntax checking/completion -- Requires Node
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" adds status/tabline
Plug 'vim-airline/vim-airline'

" adds color scheme
Plug 'morhetz/gruvbox'

" adds file explorer
Plug 'preservim/nerdtree'

call plug#end()

colorscheme gruvbox
filetype plugin indent on    " required
syntax on

"""""""""""""""""""""""
" Settings
"""""""""""""""""""""""
set relativenumber
set nu rnu
set colorcolumn=80
set background=dark
highlight ColorColumn ctermbg=0 guibg=lightgrey
set nowrap
set smartcase
set hlsearch
set noerrorbells
set tabstop=2 softtabstop=2
set expandtab
set smartindent

"""""""""""""""""""""""
" Custom Mappings
"""""""""""""""""""""""
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Opening fuzzy file search
nnoremap <leader>p :Files<cr>
map <leader>n :NERDTreeFocus<cr>

" Allow escape to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" Quick git all tracked and commit with message
map <silent> <leader>g :call GitAddCommit()<cr>

"""""""""""""""""""""""
" Custom Functions
"""""""""""""""""""""""
function! GitAddCommit()
        call inputsave()
        let message = input('message: ')
        call inputrestore()
        execute '!git commit --all --message ' . "\"" . message . "\"" 
endfunction
