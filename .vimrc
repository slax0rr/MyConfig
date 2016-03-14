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

	Plugin 'airblade/vim-gitgutter'
	Plugin 'shawncplus/phpcomplete.vim'
	"Plugin 'joonty/vim-phpqa'
	Plugin 'bling/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'
	Plugin 'sheerun/vim-polyglot'
	Plugin 'suan/vim-instant-markdown'
	Plugin 'ctrlp.vim'
	Plugin 'The-NERD-tree'
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'fatih/vim-go'
	Plugin 'WebAPI.vim'
	Plugin 'metarw'
	Plugin 'Tagbar'
	Plugin 'fugitive.vim'

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

" Reopen file on same line as it was closed
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" sharing is caring
command! -range=% VP  execute <line1> . "," . <line2> . "w !vpaste ft=" . &filetype
command! -range=% SP  silent execute <line1> . "," . <line2> . "w !curl -F 'sprunge=<-' http://sprunge.us/ | tr -d '\\n' | awk '{print $1\"?" . &filetype . "\"}' | xclip -selection clipboard"
command! -range=% IX  silent execute <line1> . "," . <line2> . "w !curl -F 'f:1=<-' ix.io | tr -d '\\n' | xclip -selection clipboard"
command!          CMD let @+ = ':' . @:
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

" Set Search Highlighting
set hlsearch

" set background
set background=dark

" Set Colorscheme
colorscheme base16-atelierheath

" color scheme settings
highlight Search ctermbg=0 ctermfg=6 cterm=bold,underline
highlight CursorLine cterm=underline

" Spell highlight
highlight SpellBad ctermbg=0 ctermfg=1 cterm=bold,underline
highlight SpellCap ctermbg=0 ctermfg=2 cterm=bold,underline
highlight SpellRare ctermbg=0 ctermfg=0 cterm=bold,underline
highlight SpellLocal ctermbg=0 ctermfg=5 cterm=bold,underline

" highligh docblock inline tags
highlight docblockTags ctermfg=180 cterm=bold

" define match for php docblock inline tags
match docblockTags "^\s\+\*\s\zs@.\{-}\ze\s"

" Highligh 80 and 120 columns
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
" Set omnifunc
set omnifunc=syntaxcomplete#Complete

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
"""""""""""""""""""""""""""
" END                     "
" Autocompletion settings "
" END                     "
"""""""""""""""""""""""""""

""""""""""""""
" BEGIN      "
" Remappings "
" BEGIN      "
""""""""""""""
" NERDTree config
map <leader>nt :NERDTree<CR>

" spellcheck
map <leader>se :setlocal spell spelllang=en_gb<CR>
map <leader>sd :setlocal nospell<CR>

" Hide search highlights for current search
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Find on PHP.net
command! -nargs=1 Pdoc !xdg-open http://php.net/<args> &
nmap <leader>pd :Pdoc <cword><CR>

" ctag bar
nmap <leader>tb :TagbarToggle<CR>

" Folding and unfolding
map ,f :set foldmethod=indent<cr>zM<cr>
map ,F :set foldmethod=manual<cr>zR<cr>

" Map \j and \sj keys to search for tags
map <leader>j g<C-]>
map <leader>sj <C-W>g<C-]>

" Horizontal split to vertical split
map <leader>h <C-w>H
map <leader>k <C-w>K

" Run some formatting rules on a file
map <leader>f :call FixFormatting()<cr>

" Instant markdown preview mapping
map <leader>md :InstantMarkdownPreview<CR>
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
" Creates a session
function! MakeSession()
    let b:sessiondir = substitute($HOME . "/" . g:vimdir . "/sessions" . substitute(getcwd(), '\(\w\):', '/\1/', 'gi'), '\', '/', 'g')
    if (filewritable(b:sessiondir) != 2)
        if has('win32')
            exe 'silent !mkdir ' b:sessiondir
        else
            exe 'silent !mkdir -p ' b:sessiondir
        endif
        redraw!
    endif
    let b:sessionfile = b:sessiondir . '/session.vim'
    exe "mksession! " . b:sessionfile
endfunction

" Updates a session, BUT ONLY IF IT ALREADY EXISTS
function! UpdateSession()
    let b:sessiondir = substitute($HOME . "/" . g:vimdir . "/sessions" . substitute(getcwd(), '\(\w\):', '/\1/', 'gi'), '\', '/', 'g')
    let b:sessionfile = b:sessiondir . "/session.vim"
    if (filereadable(b:sessionfile))
        exe "mksession! " . b:sessionfile
        echo "updating session"
    endif
endfunction

" Loads a session if it exists
function! LoadSession()
    if argc() == 0
        let b:sessiondir = substitute($HOME . "/" . g:vimdir . "/sessions" . substitute(getcwd(), '\(\w\):', '/\1/', 'gi'), '\', '/', 'g')
        let b:sessionfile = b:sessiondir . "/session.vim"
        if (filereadable(b:sessionfile))
            exe 'source ' b:sessionfile
        else
            echo "No session loaded."
        endif
    else
        let b:sessionfile = ""
        let b:sessiondir = ""
    endif
endfunction

" Fix formatting
function! FixFormatting()
    " wrap logical operators with spaces if there aren't any
    execute '%s/\(\S\{-}\)\([<>!]\{-}=\+\|[<>|]\+\)\(\S\{-}\)/\1 \2 \3/ge'
    execute '%s/[,a-zA-Z0-9 ^I]\@<!\([a-zA-Z0-9 ^I]\+\)\(&\+\)/\1 \2 /ge'
    execute '%s/< ?php/<?php/ge'
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
    execute '%s/function\s\+\(.\{-}\)\s\{-}(\(.\{-})\)\s*{/function \1(\2) {/ge'
    " Properly format class definitions
    execute '%s/\(class\|interface\)\s\+\([a-zA-Z0-9]*\)\(.\{-}\)\s*{/\1 \2\3 {/ge'
    " Retab the whole file
    execute 'retab'
    normal gg=G
    " Remove any trailing whitespace
    execute '%s/\s\+$//ge'
    " Remove excesive blank lines
    execute '%s/\n\{3,}/\r\r/e'
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
""""""""""""""""""""
" END              "
" Helper Functions "
" END              "
""""""""""""""""""""

""""""""""""""""""
" BEGIN          "
" Plugin Settins "
" BEGIN          "
""""""""""""""""""
" FuGITive status line
set laststatus=2
set statusline=%<\ %f\ %{fugitive#statusline()}

" Airline settings
" Enable powerline symbols
let g:airline_powerline_fonts = 1
" Show pretty tabline
let g:airline#extensions#tabline#enabled = 1
" Change theme for cli version
let g:airline_theme='base16'

" Turn on all python highlights of the python syntax plugin
let python_highlight_all = 1

" Disable polyglot language packages
let g:polyglot_disables = ['php']

" NERDTree config
let g:NERDTreeWinSize = 40 
let NERDTreeQuitOnOpen = 1

" DBGPavim config
let g:dbgPavimPort = 9000
let g:dbgPavimBreakAtEntry = 0
let g:dbgPavimPathMap = [
\   ['/home/slax0r/Development/projects/', '/mnt/hgfs/webserver/',]
\]

" YCM settings
let g:ycm_auto_trigger = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_cache_omnifunc = 1

" Instant markdown preview settings
let g:instant_markdown_autostart = 0
""""""""""""""""""
" END            "
" Plugin Settins "
" END            "
""""""""""""""""""

" Load environment specific files, if it exists
if !empty(glob("~/.vimrc_env"))
    source ~/.vimrc_env
endif

" Load private computer specific config file, if it exists
if !empty(glob("~/.vimrc_local"))
	source ~/.vimrc_local
endif
