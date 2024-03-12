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

" adds nice [] mappings
Plug 'tpope/vim-unimpaired'
call plug#end()

colorscheme gruvbox
filetype plugin indent on    " required
syntax on

"""""""""""""""""""""""
" Settings
"""""""""""""""""""""""
set number
set colorcolumn=80
set background=dark
highlight ColorColumn ctermbg=0 guibg=lightgrey
highlight EchoColorGreen ctermfg=green guifg=green
highlight EchoColorRed ctermfg=red guifg=red
highlight EchoColorYellow ctermfg=yellow guifg=yellow
set nowrap
set smartcase
set nohidden
set hlsearch
set noerrorbells
set tabstop=2 softtabstop=2
set expandtab
set smartindent
autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType ruby setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType javascriptreact setlocal ts=2 sts=2 sw=2
autocmd FileType typescript setlocal ts=2 sts=2 sw=2
autocmd FileType typescriptreact setlocal ts=2 sts=2 sw=2
autocmd FileType json setlocal ts=2 sts=2 sw=2

"""""""""""""""""""""""
" Custom Mappings
"""""""""""""""""""""""
let mapleader = ","

" Fast saving
nmap <leader>ws :w!<cr>

" Add new line at cursor
nmap <leader>an i<Enter><ESC>

" Replace character under cursor with new line
nmap <leader>rn s<Enter><ESC>

" Copy and Paste to System Clipboard
xmap <leader>c "*y<cr>

" Fast Window Movement
map <leader>ww :wincmd w<cr>
map <leader>wj :wincmd j<cr>
map <leader>wk :wincmd k<cr>
map <leader>wl :wincmd l<cr>
map <leader>wh :wincmd h<cr>

" Allow using Tab (Next) and Shift + Tab (Back) to navigate autocomplete
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Allow Right Arrow to confirm autocomplete suggestion
inoremap <expr> <Right> coc#pum#visible() ? coc#pum#confirm() : "\<Right>"

" Opening fuzzy file search
nnoremap <leader>P :Files<cr>
nnoremap <leader>p :GFiles<cr>
nnoremap <leader>f :Ag<cr>

" Enable space adding empty character in Normal
nnoremap <Space> i<Space><Right><ESC>

" NERDTree
map <leader>nt :NERDTreeToggle<cr>
map <leader>nf :NERDTreeFind<cr>

" Allow escape to exit terminal mode
if has("nvim")
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
endif

" Quick git commands
map <leader>gcm :call GitAllCommit()<cr>
map <leader>gs :call GitStatus()<cr>
map <leader>gpsh :call GitPush()<cr>
map <leader>gpl :call GitPull()<cr>
map <leader>gco :call GitCheckout()<cr>
map <leader>gb :call GitBranch()<cr>

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

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
        let git_diff_numstat = system("git diff --numstat | sed 's/^/           /'")
        let git_untracked_file_count = system("git ls-files -o --exclude-standard | wc -l | sed 's/^       //'")
        let git_untracked_files = system("git ls-files --other --exclude-standard | sed 's/^/           /'")

        echohl None | echon "branch:    " | echon git_branch_current
        echo ''

        if len(git_diff_shortstat) == 0 && git_untracked_file_count == 0
                echohl None | echon "status:    " | echohl EchoColorGreen | echon "clean"
        else
                echohl None | echon "status:    " | echohl EchoColorRed | echon "unclean"
        endif
        echo ''
        echohl None | echon "diff:     ".git_diff_shortstat
        echo ''
echohl None | echon git_diff_numstat
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

