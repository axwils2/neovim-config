" Enable filetype plugins
set nocompatible
filetype off

"""""""""""""""""""""""
" Line Numbers
"""""""""""""""""""""""
" show line numbers based on distance from current line
set relativenumber

" show current line number in relation to file
set nu rnu

"""""""""""""""""""""""
" Custom Mappings
"""""""""""""""""""""""
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Opening fuzzy file search
nnoremap <leader>p :Files<cr>

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

call plug#end()

colorscheme gruvbox
