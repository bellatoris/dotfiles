let s:darwin = has('mac')

" Plug buffers appear in a new tab
let g:plug_window = '-tabnew'

call plug#begin('~/.vim/plugged')

" Integration and Interfaces
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'



Plug 'suan/vim-instant-markdown'
call plug#end()
