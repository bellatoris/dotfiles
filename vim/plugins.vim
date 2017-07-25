let s:darwin = has('mac')

" Plug buffers appear in a new tab
let g:plug_window = '-tabnew'

call plug#begin('~/.vim/plugged')
Plug 'suan/vim-instant-markdown'
call plug#end()
