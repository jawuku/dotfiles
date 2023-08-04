if exists('g:GuiLoaded')
  set termguicolors
  set background=light
  colorscheme gruvbox
  GuiFont FiraCode Nerd Font Retina 16
  let g:GuiInternalClipboard = 1
  GuiPopupmenu 1
  GuiTabline 0
else
  colorscheme tender
endif

