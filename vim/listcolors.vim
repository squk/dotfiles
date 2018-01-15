let num = 255
while num >= 0
    exec 'hi col_'.num.' ctermfg='.num.' ctermbg=black'
    exec 'syn match col_'.num.' "ctermfg='.num.':...." containedIn=ALL'
    call append(0, 'ctermfg='.num.':....')
    let num = num - 1
endwhile

