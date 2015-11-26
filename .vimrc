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
else
	set rtp+=~/.vim/bundle/Vundle.vim
endif
call vundle#begin('~/' + g:vimdir + '/')

Plugin 'gmarik/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'joonty/vim-phpqa'
Plugin 'joonty/vdebug'

call vundle#end()            " required
filetype plugin indent on    " required

execute pathogen#infect()

" Reopen file on same line as it was closed
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

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

" Add current line marker
set cursorline
highlight CursorLine ctermbg=7 guibg=#333333

" Set autocompletion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" set search highligh
set hlsearch

" set colorscheme
colorscheme slate

" set font
set guifont=Consolas:h9

" remove gui elements
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  " remove left-hand scroll bar

" Key remaps
" Remap Ctrl+x Ctrl+o to Ctrl+Space (omni complete)
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
        \ "\<lt>C-n>" :
        \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
        \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
        \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" Add closing brackets when an opening bracket is written
" Squirly brackets
inoremap {  {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{  {
inoremap {}  {}
inoremap        {  {}<Left>
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

" Parenthesis
inoremap (  ()<Left>
inoremap (<CR> (<CR>)<Esc>O
inoremap ((  (
inoremap ()  ()
inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

" Square brackets
inoremap [  []<Left>
inoremap [<CR> [<CR>]<Esc>O
inoremap [[  [
inoremap []  []
inoremap        [  []<Left>
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
highlight ColorColumn ctermbg=0 guibg=#333333
let &colorcolumn="80,".join(range(120,999),",")

" ctag bar
nmap <F8> :TagbarToggle<CR>

" Folding and unfolding
map ,f :set foldmethod=indent<cr>zM<cr>
map ,F :set foldmethod=manual<cr>zR<cr>

" Map F6 and F7 keys to search for tags
map <leader>j g<C-]>
map <leader>sj <C-W>g<C-]>

" Horizontal split to vertical split
map <F11> <C-w>H
map <F12> <C-w>K

" Run some formatting rules on a file
map <leader>f :call FixFormatting()<cr>

" add custom ctags file
set tags=.tags;

" VDebug settings
let g:vdebug_options = {}
let g:vdebug_options["port"] = 9000

let g:vdebug_options["path_maps"] = {
    \    "/var/www/": "/Users/tomazlovrec/Development/vagrant/dev/"
\}

let g:vdebug_options["server"] = "0.0.0.0"
let g:vdebug_options["break_on_open"] = 0

let g:vdebug_keymap = {
\    "set_breakpoint" : "<C-b>",
\}

" Functions, functions everywhere!
" Creates a session
function! MakeSession()
  let b:sessiondir = substitute($HOME . "/" + g:vimdir + "/sessions" .  substitute(getcwd(), '\(\w\):', '/\1/', 'gei'), '/', '\', 'g')
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir ' b:sessiondir
    redraw!
  endif
  let b:sessionfile = b:sessiondir . '/session.vim'
  exe "mksession! " . b:sessionfile
endfunction

" Updates a session, BUT ONLY IF IT ALREADY EXISTS
function! UpdateSession()
  let b:sessiondir = substitute($HOME . "/" + g:vimdir + "/sessions" .  substitute(getcwd(), '\(\w\):', '/\1/', 'gei'), '/', '\', 'g')
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe "mksession! " . b:sessionfile
    echo "updating session"
  endif
endfunction

" Loads a session if it exists
function! LoadSession()
  if argc() == 0
    let b:sessiondir = substitute($HOME . "/" + g:vimdir + "/sessions" .  substitute(getcwd(), '\(\w\):', '/\1/', 'gei'), '/', '\', 'g')
    let b:sessionfile = b:sessiondir . "/session.vim"
    if (filereadable(b:sessionfile))
      exe 'source ' b:sessionfile
      highlight CursorLine ctermbg=7 guibg=#333333
      highlight ColorColumn ctermbg=0 guibg=#333333
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
	execute '%s/\(\S\{-}\)\([<>!]\{-}=\+\|[<>|&]\+\)\(\S\{-}\)/\1 \2 \3/ge'
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

au VimEnter * nested :call LoadSession()
au VimLeave * :call UpdateSession()
map <leader>m :call MakeSession()<CR>
