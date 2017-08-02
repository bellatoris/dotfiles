let s:darwin = has('mac')

" Plug buffers appear in a new tab
let g:plug_window = '-tabnew'

call plug#begin('~/.vim/plugged')
" General and Behaviour
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color
Plug 'morhetz/gruvbox'
" Plug 'chriskempson/base16-vim'
" Plug 'joshdick/onedark.vim'

" Integration and Interfaces
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'

" Browsing
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()
