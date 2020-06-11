" Find on PHP.net
command! -nargs=1 Pdoc !xdg-open http://php.net/<args> &
nmap <leader>pd :Pdoc <cword><CR>

" The bellow rempas are usually handled by tags, but sometimes those just
" don't work as desired in some of the sources I have to deal with
" search for class with the selected text as name in all files with same ext
vnoremap /c y:exe 'grep "class <C-R>"" **/*.' . expand('%:e')<CR>
" search for function with the selected text as name in all files with same ext
vnoremap /f y:exe 'grep "function <C-R>"" **/*.' . expand('%:e')<CR>

" Code Sniffer Command
command! PhpCS :cexpr system("phpcs --colors --standard=PSR2SlaxWeb " . expand("%:p")) | copen

" Mess Detector Command
command! PhpMD :cexpr system("phpmd " . expand("%:p") . " text ~/.ruleset.xml") | copen

" Disable polyglot language packages
let g:polyglot_disables = ['php']
