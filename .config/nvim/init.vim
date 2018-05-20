"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Empty guicursor because of resizing issues with nvim
set guicursor=

" Enable filetype plugins
filetype plugin on
filetype indent on

" Blink cursor on error instead of beeping (thank god for this)
set visualbell

" :W sudo saves the file
command W w !sudo tee % > /dev/null/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on 
colorscheme onedark

if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
  endif
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
" shift-space to escape
" needs terminal to send right escape sequence (\E[32;2u)
noremap <S-Space> <Esc>
inoremap <S-Space> <Esc>
vnoremap <S-Space> <Esc>

" Disable Arrow keys
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>


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
    Plug 'neovimhaskell/haskell-vim'
call plug#end()
