" mappings for the go-vim plugin
map <leader>r <Plug>(go-run)
map <leader>b <Plug>(go-build)
map <leader>t :GoTest!<cr>
map <leader>tf :GoTestFunc!<cr>
map <leader>tdf :execute 'DlvTest -- -test.run ' GetCurrFuncName()<cr>
map <leader>c <Plug>(go-coverage)
map <Leader>ds <Plug>(go-def-split)
map <Leader>dv <Plug>(go-def-vertical)
map <Leader>dt <Plug>(go-def-tab)
map <Leader>gd <Plug>(go-doc)
map <Leader>gv <Plug>(go-doc-vertical)
map <Leader>gb <Plug>(go-doc-browser)
map <Leader>s <Plug>(go-implements)
map <Leader>i <Plug>(go-info)
map <Leader>e <Plug>(go-rename)
map <Leader>gi <Plug>(go-imports)
map <Leader>gr <Plug>(go-referrers)
nmap <Leader>dd :GoDecls<cr>
nmap <Leader>ie :GoIfErr<cr>

" set folding settings
setlocal foldmethod=syntax
setlocal foldnestmax=10
setlocal nofoldenable
setlocal foldlevel=0

nmap <Leader>db :DlvToggleBreakpoint<cr>
nmap <Leader>dr :DlvConnect 127.0.0.1:40000<cr>

" highlight settings
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_rename_command = 'gopls'
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_implements_mode='gopls'

function! GetCurrFuncName()
    let funcLinePattern = "^[^ \t#/]\\{2}.*[^:]\s*$"
    let funcNamePattern = '^\s*func\s*\%((.\{-})\)*\s\(.\{-}\)(.*).*{$'

    return matchlist(getline(search(funcLinePattern, 'bWn')), funcNamePattern)[1]
endfunction

" run tests only in current file
"let b:tests = []
"let save_cursor = getcurpos()
":g/func\s\+Test/call search('Test') | call add(b:tests,  '^' . expand('<cword>'))
"call setpos('.', save_cursor)
"" use it in a mapping, providing proper package name
"exe "go test package_name -run " . join(b:tests, '\|')
"" debug msg
"echom "go test package_name -run " . join(b:tests, '\|')
