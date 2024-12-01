" Catppuccin Mocha-inspired Vim Colorscheme
syntax enable
set background=dark

highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "catppuccin_mocha"

" --- Basic UI ---
highlight Normal       guifg=#cdd6f4 guibg=#1e1e2e
highlight CursorLine   guibg=#313244
highlight CursorColumn guibg=#313244
highlight LineNr       guifg=#585b70 guibg=#1e1e2e
highlight CursorLineNr guifg=#a6e3a1
highlight StatusLine   guifg=#bac2de guibg=#313244
highlight StatusLineNC guifg=#585b70 guibg=#1e1e2e
highlight VertSplit    guifg=#585b70 guibg=#1e1e2e

" --- Syntax Highlighting ---
highlight Comment      guifg=#585b70
highlight Constant     guifg=#f38ba8
highlight String       guifg=#a6e3a1
highlight Character    guifg=#f9e2af
highlight Number       guifg=#f38ba8
highlight Boolean      guifg=#f38ba8
highlight Float        guifg=#f38ba8

highlight Identifier   guifg=#89b4fa
highlight Function     guifg=#89b4fa

highlight Statement    guifg=#cba6f7
highlight Conditional  guifg=#f38ba8
highlight Repeat       guifg=#f38ba8
highlight Label        guifg=#f38ba8
highlight Operator     guifg=#89b4fa
highlight Keyword      guifg=#cba6f7
highlight Exception    guifg=#f38ba8

highlight PreProc      guifg=#f9e2af
highlight Include      guifg=#f38ba8
highlight Define       guifg=#f38ba8
highlight Macro        guifg=#f38ba8
highlight PreCondit    guifg=#f38ba8

highlight Type         guifg=#a6e3a1
highlight StorageClass guifg=#a6e3a1
highlight Structure    guifg=#a6e3a1
highlight Typedef      guifg=#a6e3a1

highlight Special      guifg=#94e2d5
highlight SpecialChar  guifg=#94e2d5
highlight Tag          guifg=#f38ba8
highlight Delimiter    guifg=#cba6f7
highlight SpecialComment guifg=#585b70
highlight Debug        guifg=#f38ba8

highlight Underlined   guifg=#89b4fa gui=underline
highlight Ignore       guifg=#585b70
highlight Error        guifg=#f38ba8 guibg=#1e1e2e
highlight Todo         guifg=#f9e2af guibg=#1e1e2e
