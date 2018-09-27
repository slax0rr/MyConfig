" mappings for the go-vim plugin
map <leader>r <Plug>(go-run)
map <leader>b <Plug>(go-build)
map <leader>t <Plug>(go-test)
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
nmap <Leader>dd :GoDecls<cr>

" set folding settings
setlocal foldmethod=syntax
setlocal foldnestmax=10
setlocal nofoldenable
setlocal foldlevel=0

" run imports before saving
au BufWritePre <buffer> :GoImports
