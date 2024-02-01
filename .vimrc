" be iMproved, required
set nocompatible

"""""""""""""""""""
" BEGIN           "
" Plug settings   "
" BEGIN           "
"""""""""""""""""""
if !empty(glob("~/.vim/autoload/plug.vim"))
    call plug#begin('~/.vim/plugged')

    Plug 'airblade/vim-gitgutter'
    Plug 'fatih/vim-go'
    Plug 'vim-scripts/WebAPI.vim'
    Plug 'vim-scripts/metarw'
    Plug 'vim-scripts/fugitive.vim'
    Plug 'mattn/emmet-vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'vim-scripts/jdaddy.vim'
    Plug 'vim-scripts/localvimrc'
    Plug 'cespare/vim-toml'
    Plug 'sebdah/vim-delve'
    Plug 'kylef/apiblueprint.vim'
    Plug 'vim-scripts/utl.vim'
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'aquach/vim-http-client'
    Plug 'mattn/calendar-vim'
    Plug 'preservim/nerdcommenter'
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'inkarkat/vim-ingo-library'
    Plug 'inkarkat/vim-SyntaxRange'
    Plug 'hashivim/vim-terraform'
    Plug 'tpope/vim-speeddating'
    Plug 'junegunn/vim-easy-align'
    Plug 'mracos/mermaid.vim'
    Plug 'jclsn/glow.vim'
    Plug 'jceb/vim-orgmode'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'embear/vim-localvimrc'
    Plug 'ruanyl/vim-gh-line'
    Plug 'takac/vim-hardtime'

    call plug#end()
endif
"""""""""""""""""""
" END             "
" Plug settings   "
" END             "
"""""""""""""""""""

"""""""""""""""""""
" BEGIN           "
" Package stuff   "
" BEGIN           "
"""""""""""""""""""
packloadall
silent! helptags ALL
"""""""""""""""""""
" END             "
" Package stuff   "
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

" dir settings
set backupdir=~/tmp
set undodir=~/tmp/un
set directory=~/tmp/sw//

" enable undofile
set undofile

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
"highlight Comment cterm=italic
highlight CursorLine cterm=underline ctermbg=0

" Spell highlight
highlight SpellCap ctermbg=0 ctermfg=111 cterm=bold,underline
highlight SpellRare ctermbg=0 ctermfg=16 cterm=bold,underline
highlight SpellLocal ctermbg=0 ctermfg=185 cterm=bold,underline

" Highlight 80 and 120 columns
let &colorcolumn="80,".join(range(120,130),",")

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
" esc remap
inoremap jj <Esc>
vnoremap jj <Esc>

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

" nerd tree close
map <C-c> :NERDTreeClose<CR>

" nerd tree toggle
map <C-n> :NERDTreeFocus<CR>

" nerd tree - current file
map <leader>ee :NERDTreeFind<CR>

" base64 encode registry
nnoremap <leader>64 :exe 'norm a' . system('base64 -w 0', @")<cr>

" base64 decode registry
nnoremap <leader>64d :exe 'norm a' . system('base64 --decode -w 0', @")<cr>

" no arrows
nnoremap <Left> :echo "No left for you!"<CR>
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
inoremap <Left> <C-o>:echo "No left for you!"<CR>

nnoremap <Right> :echo "No right for you!"<CR>
vnoremap <Right> :<C-u>echo "No right for you!"<CR>
inoremap <Right> <C-o>:echo "No right for you!"<CR>

nnoremap <Up> :echo "No up for you!"<CR>
vnoremap <Up> :<C-u>echo "No up for you!"<CR>
inoremap <Up> <C-o>:echo "No up for you!"<CR>

nnoremap <Down> :echo "No down for you!"<CR>
vnoremap <Down> :<C-u>echo "No down for you!"<CR>
inoremap <Down> <C-o>:echo "No down for you!"<CR>
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

" Stage all and commit
function! GitStageAndCommit()
    silent execute '!git add -A .'
    Gcommit -v
endfunction
nnoremap <leader>gc :call GitStageAndCommit()<CR>
nnoremap <leader>gp :Gpush<CR>

" push all commits and open a PR on GitHub with the f3 tool
function! GitPushAndOpenPR()
    Gpush -u origin HEAD
    !f3 github pr
endfunction
nnoremap <leader>pr :call GitPushAndOpenPR()<CR>
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
let NERDTreeWinSize = 45

" set agenda file for org-mode
let g:org_agenda_files = ['~/Documents/TODO.org']

" markdown easyalign
au FileType markdown vmap <Leader>a :EasyAlign*<Bar><Enter>

" syntax highlighting on markdown code blocks
let g:markdown_fenced_languages = ['html', 'go', 'vim', 'json', 'xml']

" enable hardtime
let g:hardtime_default_on = 1

" stop hardtime in NERDtree
let g:hardtime_ignore_buffer_patterns = ["NERD.*"]

" stop hardtime in quickfix
let g:hardtime_ignore_quickfix = 1

" reduce timeout for hardtime
let g:hardtime_timeout = 500

" reset hardtime timeout on numbered navigation (10j)
let g:hardtime_motion_with_count_resets = 1
"""""""""""""""""""
" END             "
" Plugin Settings "
" END             "
"""""""""""""""""""

" Load private computer specific config file, if it exists
if !empty(glob("~/.vimrc_local"))
    source ~/.vimrc_local
endif
