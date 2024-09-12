set autoindent expandtab tabstop=2 shiftwidth=2

set foldmethod=manual

"syntax region htmlFold start="<\z(\<\(area\|base\|br\|col\|command\|embed\|hr\|img\|input\|keygen\|link\|meta\|para\|source\|track\|wbr\>\)\@![a-z-]\+\>\)\%(\_s*\_[^/]\?>\|\_s\_[^>]*\_[^>/]>\)" end="</\z1\_s*>" fold transparent keepend extend containedin=htmlHead,htmlH\d

"set foldexpr=HtmlFoldExpr()
"
"set foldlevelstart=0
"
"function! HtmlFoldExpr()
"    let l:line = getline(v:lnum)
"    if l:line =~? '^\s*<\/\w\+>' " Closing tag
"        return '<1'
"    elseif l:line =~? '^\s*<\w\+\([^>]*\)>\s*$' " Opening tag
"        return '1'
"    elseif l:line =~? '^\s*<\w\+\([^>]*\)/\s*>\s*$' " Self-closing tag
"        return '0'
"    else
"        return '='
"    endif
"endfunction
