if exists('g:GuiLoaded')
    set termguicolors
    set background=light
    colorscheme NeoSolarized
    call rpcnotify(1, 'Gui', 'Font', 'Fira Mono for Powerline 16')
    let g:GuiInternalClipboard = 1
    GuiPopupmenu 1
    GuiTabline 0
else
    colorscheme tender
endif
