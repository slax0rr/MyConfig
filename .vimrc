" be iMproved, required
set nocompatible

"""""""""""""""""""
" BEGIN           "
" Vundle settings "
" BEGIN           "
"""""""""""""""""""
if !empty(glob("~/.vim/bundle/Vundle.vim"))
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    Plugin 'airblade/vim-gitgutter'
    Plugin 'suan/vim-instant-markdown'
    Plugin 'fatih/vim-go'
    Plugin 'WebAPI.vim'
    Plugin 'metarw'
    Plugin 'fugitive.vim'
    Plugin 'mattn/emmet-vim'
    Plugin 'pangloss/vim-javascript'
    Plugin 'mxw/vim-jsx'
    Plugin 'editorconfig/editorconfig-vim'
    Plugin 'joonty/vdebug'
    Plugin 'localrc.vim'
    Plugin 'junegunn/fzf'
    Plugin 'jdaddy.vim'

    call vundle#end()
endif
"""""""""""""""""""
" END             "
" Vundle settings "
" END             "
"""""""""""""""""""

"""""""""""""""""""""""""""
" BEGIN                   "
" Editor related settings "
" BEGIN                   "
"""""""""""""""""""""""""""
" Enable filetype plugin and indent
filetype plugin indent on

" Tab and indent settings
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Backup file dir
set backupdir=~/tmp

" Line numbers
set relativenumber

" Set backspace to work as in other apps
set backspace=2

" Enable wmnu
set wmnu

" add custom ctags file
set tags=.tags;

" set forward slashes
set shellslash

" Disable mouse
set mouse=

" Set listchars
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
set list

" Disable visual bell
set t_vb=

" Reopen file on same line as it was closed
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" hide files, instead of closing
set hidden

" set folding
set foldmethod=indent
set foldlevel=99
"""""""""""""""""""""""""""
" END                     "
" Editor related settings "
" END                     "
"""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" BEGIN                      "
" Graphical related settings "
" BEGIN                      "
""""""""""""""""""""""""""""""
" Syntax Highlighting
syntax on
au BufRead,BufNewFile *.tpl set filetype=smarty 

" Set Search Highlighting
set hlsearch

" color scheme settings
highlight Search ctermbg=0 ctermfg=15 cterm=bold,underline
highlight CursorLine cterm=underline ctermbg=0
highlight CursorColumn ctermbg=0
highlight CursorLineNr ctermbg=NONE ctermfg=NONE
highlight ColorColumn ctermbg=0
highlight WildMenu ctermbg=12 ctermfg=0
highlight LineNr ctermbg=0
highlight SignColumn ctermbg=NONE
highlight VertSplit ctermbg=8 ctermfg=8
highlight TabLineFill ctermbg=8 ctermfg=8
highlight TabLine ctermbg=8 ctermfg=15
highlight TabLineSel ctermbg=7 ctermfg=15

" Spell highlight
highlight SpellBad ctermbg=0 ctermfg=13 cterm=bold,underline
highlight SpellCap ctermbg=0 ctermfg=12 cterm=bold,underline
highlight SpellRare ctermbg=0 ctermfg=0 cterm=bold,underline
highlight SpellLocal ctermbg=0 ctermfg=11 cterm=bold,underline

" higlight SpecialKey
highlight SpecialKey ctermfg=8

" statusline
highlight StatusLine ctermfg=8 ctermbg=7
highlight StatusLineNC ctermfg=0 ctermbg=7

" Highlight 80 and 120 columns
let &colorcolumn="80,".join(range(120,999),",")

" Add cursorline and cursorcolumn
set cursorline
set cursorcolumn
""""""""""""""""""""""""""""""
" END                        "
" Graphical related settings "
" END                        "
""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""
" BEGIN                   "
" Autocompletion settings "
" BEGIN                   "
"""""""""""""""""""""""""""
" Add closing brackets when an opening bracket is written
" Squirly brackets
inoremap {  {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{  {
inoremap {}  {}
inoremap {  {}<Left>
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

" Parenthesis
inoremap (  ()<Left>
inoremap (<CR> (<CR>)<Esc>O
inoremap ((  (
inoremap ()  ()
inoremap (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

" Square brackets
inoremap [  []<Left>
inoremap [<CR> [<CR>]<Esc>O
inoremap [[  [
inoremap []  []
inoremap [  []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

" Add closing quotes when an opening bracket is written, and jump over closing
inoremap "  ""<Left>
inoremap "" "
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
inoremap '  ''<Left>
inoremap '' '
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"

" Autocompletion mappings
function! InsertTabWrapper()
  if pumvisible()
    return "\<c-n>"
  endif
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-x>\<c-o>"
  endif
endfunction
inoremap <expr><tab> InsertTabWrapper()
inoremap <expr><s-tab> pumvisible()?"\<c-p>":"\<c-d>"
"""""""""""""""""""""""""""
" END                     "
" Autocompletion settings "
" END                     "
"""""""""""""""""""""""""""

""""""""""""
" BEGIN    "
" Commands "
" BEGIN    "
""""""""""""
" sharing is caring
command! -range=% VP  execute <line1> . "," . <line2> . "w !vpaste ft=" . &filetype
command! -range=% SP  silent execute <line1> . "," . <line2> . "w !curl -F 'sprunge=<-' http://sprunge.us/ | tr -d '\\n' | awk '{print $1\"?" . &filetype . "\"}' | xclip -selection clipboard"
command! -range=% IX  silent execute <line1> . "," . <line2> . "w !curl -F 'f:1=<-' ix.io | tr -d '\\n' | xclip -selection clipboard"
command!          CMD let @+ = ':' . @:

" search in all files with same extension
command! -nargs=* Sext silent execute 'grep ' . expand('<f-args>') . ' **/*.' . expand('%:e')
" search in all files
command! -nargs=* Sall silent execute 'grep ' . expand('<f-args>') . ' **/*'

""""""""""""
" END      "
" Commands "
" END      "
""""""""""""

""""""""""""""
" BEGIN      "
" Remappings "
" BEGIN      "
""""""""""""""
" spellcheck
map <leader>se :setlocal spell spelllang=en_gb<CR>
map <leader>sd :setlocal nospell<CR>

" Hide search highlights for current search
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Find on PHP.net
command! -nargs=1 Pdoc !xdg-open http://php.net/<args> &
nmap <leader>pd :Pdoc <cword><CR>

" Map \j and \sj keys to search for tags
map <leader>j g<C-]>
map <leader>sj <C-W>g<C-]>
map <silent><leader>tp <C-W>g}

" Horizontal split to vertical split
map <leader>h <C-w>H
map <leader>k <C-w>K

"split navigations
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" Run some formatting rules on a file
map <leader>f :call FixFormatting()<cr>

" Instant markdown preview mapping
map <leader>md :InstantMarkdownPreview<CR>

" open a file in the same dir as the current one (borrowed from mgedmin)
map <expr>      <leader>E              ":e ".expand("%:h")."/"

" open the fuzzy finder
map <leader>e :FZF<CR>

" search for visually selected in all files with same ext
vnoremap // y:exe 'grep "<C-R>"" **/*.' . expand('%:e')<CR>
" search for visually selected in all files
vnoremap /a y:grep "<C-R>"" **/*.*

" The bellow rempas are usually handled by tags, but sometimes those just
" don't work as desired in some of the sources I have to deal with
" search for class with the selected text as name in all files with same ext
vnoremap /c y:exe 'grep "class <C-R>"" **/*.' . expand('%:e')<CR>
" search for function with the selected text as name in all files with same ext
vnoremap /f y:exe 'grep "function <C-R>"" **/*.' . expand('%:e')<CR>
""""""""""""""
" END        "
" Remappings "
" END        "
""""""""""""""

""""""""""""""""""""
" BEGIN            "
" Helper Functions "
" BEGIN            "
""""""""""""""""""""
" Fix formatting
function! FixFormatting()
    " wrap logical operators with spaces if there aren't any
    execute '%s/\(\S\{-}\)\([<>!]\{-}=\+\|[<>|]\+\)\(\S\{-}\)/\1 \2 \3/ge'
    execute '%s/[,a-zA-Z0-9 ^I]\@<!\([a-zA-Z0-9 ^I]\+\)\(&\+\)/\1 \2 /ge'
    execute '%s/< ?php/<?php/ge'
    execute '%s/-\s>\(\S\)/->\1/g'
    " Add a space after control structure keyword, and after closing parenthesis
    execute '%s/\(if\|for\|foreach\|while\|switch\)\s\{-}\((.*)\)\s\{-}{/\1 \2 {/ge'
    " Turn else if into elseif
    execute '%s/}\s\{-}else\s*if\s\{-}/} elseif/ge'
    " Wrap else statement with spaces if there aren't any
    execute '%s/}\s\{-}else\s\{-}{/} else {/ge'
    " Remove whitespace in parenthesis
    execute '%s/(\s*\(.*\)\s*)/(\1)/ge'
    " Remove excesive whitespace
    execute '%s/\(\S\+\) \{2,}\(\S\+\)/\1 \2/ge'
    execute '%s/\(\S\+\) \{2,}\(\S\+\)/\1 \2/ge'
    " Add whitespace after each comma
    execute '%s/,\(\S\+\)/, \1/ge'
    " Properly format function definitions
    execute '%s/function\s\+\(.\{-}\)\s\{-}(\(.\{-}\))\s*{/function \1(\2)\r{/ge'
    " Properly format class definitions
    execute '%s/\(class\|interface\)\s\+\([a-zA-Z0-9]*\)\(.\{-}\)\s*{/\1 \2\3\r{/ge'
    " Remove any trailing whitespace
    execute '%s/\s\+$//ge'
    " Remove excesive blank lines
    execute 'g/^\n\{2,}/d'
    " Remove blank lines before closing curly braces
    execute 'g/^\n.*}/d'
    " Retab the whole file
    execute 'retab'
    normal gg=G
endfunction

" Change to relative numbering and back
function! NumberToggle()
    if (&relativenumber == 1)
        set number
        set norelativenumber
    else
        set nonumber
        set relativenumber
    endif
endfunction
nnoremap <leader>n :call NumberToggle()<CR>

" Code Sniffer Command
command! PhpCS :cexpr system("phpcs --colors --standard=PSR2SlaxWeb " . expand("%:p")) | copen

" Mess Detector Command
command! PhpMD :cexpr system("phpmd " . expand("%:p") . " text ~/.ruleset.xml") | copen
""""""""""""""""""""
" END              "
" Helper Functions "
" END              "
""""""""""""""""""""

"""""""""""""""""""
" BEGIN           "
" Plugin Settings "
" BEGIN           "
"""""""""""""""""""
" FuGITive status line
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Airline settings
" Enable powerline symbols
"let g:airline_powerline_fonts = 1
" Show pretty tabline
"let g:airline#extensions#tabline#enabled = 1
" Change theme for cli version
"let g:airline_theme='base16'

" Turn on all python highlights of the python syntax plugin
let python_highlight_all = 1

" Disable polyglot language packages
let g:polyglot_disables = ['php']

" DBGPavim config
"let g:dbgPavimPort = 9000
"let g:dbgPavimBreakAtEntry = 0
"let g:dbgPavimPathMap = [
"\   ['/home/slax0r/dev/projects/shops/kastner/', '/var/www/html/koedocker.acl.local/',],
"\   ['/home/slax0r/dev/projects/shops/forstinger/', '/var/www/html/fordocker.acl.local/',],
"\   ['/home/slax0r/dev/projects/shops/intersport/', '/var/www/html/ispdocker.acl.local/',],
"\   ['/home/slax0r/dev/projects/shops/deutschebahn/', '/var/www/html/ubkdocker.acl.local/',],
"\   ['/home/slax0r/dev/projects/pim/elsta/data/www/', '/var/www/',]
"\]

" Vdebug settings
let g:vdebug_options = {
\   "port": 9000,
\   "timeout": 60,
\   "break_on_open": 0,
\   "path_maps": {
\       "/var/www": "/home/slax0r/dev/projects/post/shopware5.2/data/www/",
\       "/var/www/html/koedocker.acl.local": "/home/slax0r/dev/projects/shops/kastner"
\   }
\}

" Instant markdown preview settings
let g:instant_markdown_autostart = 0

" emmet config
let g:user_emmet_complete_tag = 1

" vim-go settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" setup the editorconfig plugin
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" force netrw directory listing to display line numbers
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
"""""""""""""""""""
" END             "
" Plugin Settings "
" END             "
"""""""""""""""""""

" Load environment specific files, if it exists
if !empty(glob("~/.vimrc_env"))
    source ~/.vimrc_env
endif

" Load private computer specific config file, if it exists
if !empty(glob("~/.vimrc_local"))
    source ~/.vimrc_local
endif
