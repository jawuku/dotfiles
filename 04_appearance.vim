" Airline ------------------------------
" let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'papercolor'
let g:airline#extensions#whitespace#enabled = 0

"Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


" Airline unicode symbols
" Uncomment these and disable the Powerline symbols to use
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '◀'
"let g:airline_left_sep = '»'
"let g:airline_right_sep = '«'
"let g:airline_symbols.readonly = '🔒'
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.maxlinenr = '㏑'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.notexists = '∄'

" Rainbow Parentheses Options
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Colour schemes

set guifont=Roboto\ Mono\ for\ Powerline\ 14
set termguicolors
set background=dark
colorscheme dark_plus

" Fisadev's dark colour scheme is a nice alternative in text mode
" let &t_Co = 256
" colorscheme fisa
" AirlineTheme bubblegum

" Two new user-defined commands to select Fisa or NeoSolarized colours
command SolarPaper set termguicolors | set background=dark | colorscheme NeoSolarized
command Fisa let &t_Co =256 | colorscheme fisa
command Darkplus set termguicolors | colorscheme dark_plus
