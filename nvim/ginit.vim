if exists('g:GuiLoaded')
    set cursorline
    augroup NrHighlight
        autocmd!
        autocmd VimEnter,WinEnter,BufEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
    augroup END

    colorscheme desert
    Guifont Space Mono for Powerline:h11
endif
