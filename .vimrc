" be iMproved, required
set nocompatible

"""""""""""""""""""
" BEGIN           "
" Vundle settings "
" BEGIN           "
"""""""""""""""""""
" TODO: replace vundle with vim-plug
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
    Plugin 'editorconfig/editorconfig-vim'
    Plugin 'localrc.vim'
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    Plugin 'jdaddy.vim'
    Plugin 'localvimrc'
    Plugin 'cespare/vim-toml'
    Plugin 'sebdah/vim-delve'
    Plugin 'kylef/apiblueprint.vim'
    Plugin 'utl.vim'
    Plugin 'godlygeek/tabular'
    Plugin 'plasticboy/vim-markdown'
    Plugin 'aquach/vim-http-client'
    Plugin 'mattn/calendar-vim'
    Plugin 'preservim/nerdcommenter'
    Plugin 'preservim/nerdtree'
    Plugin 'Xuyuanp/nerdtree-git-plugin'

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

" set updatetime
set updatetime=50

" Tab and indent settings
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Backup file dir
set backupdir=~/tmp
set undodir=~/tmp/un

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

" set sql ft for *.pgsql files
autocmd BufNewFile,BufRead *.pgsql set ft=sql

" export .org file to HTML on write
au BufWritePost *.org silent! OrgExportToHTML
"""""""""""""""""""""""""""
" END                     "
" Editor related settings "
" END                     "
"""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" BEGIN                      "
" GUI options                "
" BEGIN                      "
""""""""""""""""""""""""""""""
if has('gui_running')
    " set gui options
    set guioptions=agit

    set guifont=PragmataPro\ 10
endif
""""""""""""""""""""""""""""""
" END                        "
" GUI options                "
" END                        "
""""""""""""""""""""""""""""""

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

" set colorscheme
colorscheme apprentice

" color scheme settings
highlight Comment cterm=italic
highlight CursorLine cterm=underline ctermbg=0

" Spell highlight
highlight SpellCap ctermbg=0 ctermfg=111 cterm=bold,underline
highlight SpellRare ctermbg=0 ctermfg=16 cterm=bold,underline
highlight SpellLocal ctermbg=0 ctermfg=185 cterm=bold,underline

" Highlight 80 and 120 columns
let &colorcolumn="80,".join(range(120,999),",")

" Add cursorline and cursorcolumn
set cursorline
set cursorcolumn

" API Blueprint filetype
autocmd BufNewFile,BufRead *.apib set ft=apiblueprint
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
" TODO: replace the mess with tpope/vim-surround
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
command! -range=% IX  silent execute <line1> . "," . <line2> . "w !curl -F 'f:1=<-' ix.io | tr -d '\\n' | awk '{print $1\"/" . &filetype . "\"}' | xclip -selection clipboard"
command! -range=% PT  silent execute <line1> . "," . <line2> . "w !curl -F c=@- https://ptpb.pw/ | grep \"url:\" | awk '{print $2\"/" . &filetype . "\"}' | xclip -selection clipboard"
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

" open a file in the same dir as the current one (borrowed from mgedmin)
map <expr> <leader>E ":e ".expand("%:h")."/"

" open the fuzzy finder
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ft :Tags<CR>

" search for visually selected
vnoremap // y:Ag <C-R>"<CR>

" copy current file path to clipboard
noremap <leader>c :let @+ = expand("%")<CR>

" open terminal
noremap <leader>x :terminal<CR>
noremap <leader>X :shell<CR>

" exec HTTPClientDoRequest
nnoremap <leader>hr :HTTPClientDoRequest<CR>

" format XML
nnoremap <leader>fx :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"<CR>

" format JSON
nnoremap <leader>fj :%!python -m json.tool

" nerd tree toggle
map <C-n> :NERDTreeToggle<CR>

" nerd tree - current file
map <leader>ee :NERDTreeFind<CR>
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

"""""""""""""""""""
" BEGIN           "
" Plugin Settings "
" BEGIN           "
"""""""""""""""""""
" FuGITive status line
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" emmet config
let g:user_emmet_complete_tag = 1

" setup the editorconfig plugin
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" force netrw directory listing to display line numbers
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" disable localvimrc sandbox mode
let g:localvimrc_sandbox = 0

" disable asking to load loaclvimrc file, if it's there, load it
let g:localvimrc_ask = 0

" set nerd tree size
let NERDTreeWinSize = 25
"""""""""""""""""""
" END             "
" Plugin Settings "
" END             "
"""""""""""""""""""

" Load private computer specific config file, if it exists
if !empty(glob("~/.vimrc_local"))
    source ~/.vimrc_local
endif
