if exists('g:GuiLoaded')
    set cursorline
    augroup NrHighlight
        autocmd!
        autocmd VimEnter,WinEnter,BufEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
    augroup END

    colorscheme gruvbox
    GuiFont Ubuntu Mono derivative Powerline:h12
endif
