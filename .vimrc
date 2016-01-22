" Syntax settings
syntax on
set background=dark

set nocompatible              " be iMproved, required
filetype off                  " required

let g:vimdir = ".vim"
if has("win32")
    let g:vimdir = "vimfiles"
endif

" set the runtime path to include Vundle and initialize
if has("win32")
    set rtp+=~/vimfiles/bundle/Vundle.vim
    call vundle#begin('~/' . g:vimdir . '/')
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

Plugin 'gmarik/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'joonty/vim-phpqa'
Plugin 'alvan/vim-php-manual'
Plugin 'bling/vim-airline'
Plugin 'sheerun/vim-polyglot'
Plugin 'suan/vim-instant-markdown'
Plugin 'ctrlp.vim'

call vundle#end()            " required
filetype plugin indent on    " required

execute pathogen#infect()

" Tab and indent settings
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" Backup file dir
set backupdir=~/tmp

" Line numbers
set number

" FuGITive status line
set laststatus=2
set statusline=%<\ %f\ %{fugitive#statusline()}

" Set backspace to work as in other apps
set backspace=2

" Enable wmnu
set wmnu

" Set autocompletion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" set search highligh
set hlsearch

" set colorscheme
colorscheme base16-atelierheath

" set font
if has('gui_gtk2')
    set guifont=Hack\ 9
else
    set guifont=Hack:h9
endif

" remove gui elements
set guioptions-=m  " remove menu bar
set guioptions-=T  " remove toolbar
set guioptions-=r  " remove right-hand scroll bar
set guioptions-=L  " remove left-hand scroll bar

" add custom ctags file
set tags=.tags;

" set forward slashes
set shellslash

" Disable mouse
set mouse=

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
map <leader>nt :NERDTree<CR>

" Add cursorline and cursorcolumn
set cursorline
set cursorcolumn

" color scheme settings
highlight Search ctermbg=0 ctermfg=1 cterm=bold,underline
highlight CursorLine cterm=underline

" Key remaps
" Remap Ctrl+x Ctrl+o to Ctrl+Space (omni complete)
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\   "\<lt>C-n>" :
\   "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\   "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\   "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

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

" Hide search highlights for current search
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Find on PHP.net
command! -nargs=1 Pdoc !xdg-open http://php.net/<args> &
nmap <leader>pd :Pdoc <cword><CR>

" Autocomplete already-existing words in the file with tab (extremely useful!)
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Highligh 80 and 120 columns
let &colorcolumn="80,".join(range(120,999),",")

" ctag bar
nmap <leader>tb :TagbarToggle<CR>

" Folding and unfolding
map ,f :set foldmethod=indent<cr>zM<cr>
map ,F :set foldmethod=manual<cr>zR<cr>

" Map F6 and F7 keys to search for tags
map <leader>j g<C-]>
map <leader>sj <C-W>g<C-]>

" Horizontal split to vertical split
map <leader>h <C-w>H
map <leader>k <C-w>K

" Run some formatting rules on a file
map <leader>f :call FixFormatting()<cr>

" Debugger config
let g:dbgPavimPort = 9000
let g:dbgPavimBreakAtEntry = 0
"\   "/mnt/hgfs/webserver/": "/media/sf_S_DRIVE/projects/"

" Functions, functions everywhere!
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

" DBGPavim config
let g:dbgPavimPathMap = [['/home/slax0r/Development/projects/', '/mnt/hgfs/webserver/',]]

" Instant markdown preview settings
let g:instant_markdown_autostart = 0
map <leader>md :InstantMarkdownPreview<CR>

" Reopen file on same line as it was closed
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    au VimEnter * nested :call LoadSession()
    au VimLeave * :call UpdateSession()
	au FileType php set keywordprg=pman
endif
map <leader>m :call MakeSession()<CR>
map <leader>l :call LoadSession()<CR>

" Load environment specific files, if it exists
if !empty(glob("~/.vimrc_env"))
    source ~/.vimrc_env
endif

" Load computer specific config file, if it exists
if !empty(glob("~/.vimrc_local"))
	source ~/.vimrc_local
endif
