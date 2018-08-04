let s:darwin = has('mac')

" Plug buffers appear in a new tab
let g:plug_window = '-tabnew'

call plug#begin('~/.vim/plugged')
" General and Behaviour
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

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
Plug 'editorconfig/editorconfig-vim'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Browsing
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Scala
Plug 'derekwyatt/vim-scala'
" Plug 'ensime/ensime-vim'

" Rust
Plug 'rust-lang/rust.vim'

" Kotlin
Plug 'udalov/kotlin-vim'

" TypeScript
Plug 'leafgarland/typescript-vim'

" Commentary
Plug 'tpope/vim-commentary'

" Jenkinsfile
Plug 'martinda/Jenkinsfile-vim-syntax'

" LaTeX
Plug 'vim-latex/vim-latex'

call plug#end()
