"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Empty guicursor because of resizing issues with nvim
set guicursor=

" Enable mouse scrolling (and visual select)
set mouse=a

" Status Line always shown
set laststatus=2

" Show at least one line above/below cursor when scrolling
set scrolloff=1

" Enable filetype plugins
filetype plugin on
filetype indent on

" Blink cursor on error instead of beeping (thank god for this)
set visualbell

" :w!! sudo saves the file
cmap w!! w suda://%

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on 
colorscheme onedark

if has('termguicolors')
    set termguicolors
endif

" Tabs expanded into 4 spaces.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"Show invisibles
set list
set listchars=tab:▸\ ,eol:¬

" Autocommands
if has("autocmd")
    " Don't insert auto comments on newline
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key remappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backspace to clear search highlighting
nnoremap <silent> <Backspace> :nohl<CR>

" Nerd tree toggle
map <C-n> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
    Plug 'kelwin/vim-smali'
    Plug 'gburca/vim-logcat'
    Plug 'lambdalisue/suda.vim'
    Plug 'scrooloose/nerdtree'
call plug#end()
