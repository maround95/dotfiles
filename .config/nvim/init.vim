"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Empty guicursor because of resizing issues with nvim
set guicursor=

" Enable mouse scrolling (and visual select)
set mouse=a

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
" shift-space to escape
" needs terminal to send the right escape sequence (\E[32;2u)
"noremap <S-Space> <Esc>
"inoremap <S-Space> <Esc>
"vnoremap <S-Space> <Esc>

" Disable Arrow keys
" noremap <Left> <Nop>
" noremap <Right> <Nop>
" noremap <Up> <Nop>
" noremap <Down> <Nop>
" inoremap <Left> <Nop>
" inoremap <Right> <Nop>
" inoremap <Up> <Nop>
" inoremap <Down> <Nop>

" Backspace to clear search highlighting
nnoremap <silent> <Backspace> :nohl<CR>

" Nerd tree toggle
map <C-n> :NERDTreeToggle<CR>

"" a basic set up for LanguageClient-Neovim
"" << LSP >> {{{
"let g:LanguageClient_autoStart = 0
"nnoremap <leader>lcs :LanguageClientStart<CR>
"" if you want it to turn on automatically
"" let g:LanguageClient_autoStart = 1
"
"let g:LanguageClient_serverCommands = {
"    \ 'python': ['pyls'],
"    \ 'rust': ['rustup', 'run', 'nightly-2019-02-08', 'rls'],
"    \ 'javascript': ['javascript-typescript-stdio'],
"    \ 'go': ['go-langserver'] }
"
"noremap <silent> H :call LanguageClient_textDocument_hover()<CR>
"noremap <silent> Z :call LanguageClient_textDocument_definition()<CR>
"noremap <silent> R :call LanguageClient_textDocument_rename()<CR>
"noremap <silent> S :call LanugageClient_textDocument_documentSymbol()<CR>
"" }}}

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
    Plug 'godlygeek/tabular'
    Plug 'lambdalisue/suda.vim'
    Plug 'scrooloose/nerdtree'
call plug#end()
