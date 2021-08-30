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

Plug 'jremmen/vim-ripgrep'
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
highlight EchoColorGreen ctermfg=green guifg=green
highlight EchoColorRed ctermfg=red guifg=red
highlight EchoColorYellow ctermfg=yellow guifg=yellow
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

" Quick git commands
map <leader>gcm :call GitAllCommit()<cr>
map <leader>gs :call GitStatus()<cr>
map <leader>gpsh :call GitPush()<cr>
map <leader>gpl :call GitPull()<cr>
map <leader>gco :call GitCheckout()<cr>
map <leader>gb :call GitBranch()<cr>

"""""""""""""""""""""""
" Custom Functions
"""""""""""""""""""""""
function! GitAllCommit()
        call inputsave()
        let message = input('message: ')
        call inputrestore()
        execute '!git commit --all --message ' . "\"" . message . "\"" 
endfunction

function! GitStatus()
        let git_branch_current = substitute(system("git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'"), '\n\+$', '', '')
        let git_diff_shortstat = system("git diff --shortstat")
        let git_diff_numstat = system("git diff --numstat | sed 's/^//'")
        let git_untracked_file_count = '0'
        let git_untracked_files = system("git ls-files --other --exclude-standard | sed 's/^/           /'")

        echohl None | echon "branch:    " | echon git_branch_current
        echo ''

        if len(git_diff_shortstat) == 0
                echohl None | echon "status:    " | echohl EchoColorGreen | echon "clean"
        else
                echohl None | echon "status:    " | echohl EchoColorRed | echon "unclean"
        endif
        echo ''
        echohl None | echon "diff:     ".git_diff_shortstat
        echo ''
        echohl None | echon "           ".git_diff_numstat
        echo ''
        echohl None | echon "untracked: ".git_untracked_file_count
        echo ''
        echo git_untracked_files

endfunction

function! GitPush()
        execute '!git push'
endfunction

function! GitPull()
        execute '!git pull'
endfunction

function! GitIsCleanWorkTree()
        echo 'got here'
        let are_file_changes = system("! git diff-files --quiet --ignore-submodules")
        echom are_file_changes
        if are_file_changes
                echo 'are_file_changes'
                return 1
        endif

        let are_text_changes = system("git diff-index --cached --quiet --ignore-submodules HEAD --")
        if are_text_changes
                echo 'are text_changes'
                return 1
        endif

        echo 'returning 0'
        return 0
endfunction

function! GitCheckout()
        call inputsave()
        let branch = input('branch: ')
        call inputrestore()
        execute '!git checkout ' . branch
endfunction

function! GitBranch()
        call inputsave()
        let branch = input('branch: ')
        call inputrestore()
        execute '!git checkout -b' . branch
endfunction

