" Empty guicursor because of resizing issues with nvim
set guicursor=

" Don't try to be vi compatible
set nocompatible

" For plugins to load correctly
filetype plugin indent on

" Enable syntax highlighting
syntax on 
colorscheme onedark

" Blink cursor on error instead of beeping (thank god for this)
set visualbell

" Tabs expanded into 2 spaces.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Don't insert auto comments on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
  endif
endif

