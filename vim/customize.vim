" 文件名称与函数前缀要一致
function! customize#before() abort
    " 文件管理在左边
    let g:vimfiler_direction = 'topleft'
    " tagbar 在右边
    let g:tagbar_left = 0

    " n 总是向后搜索， N 总是向前搜索
    nnoremap <expr> n  'Nn'[v:searchforward]
    nnoremap <expr> N  'nN'[v:searchforward]

    " 使用 H 和 L 快速定位
    nnoremap H ^
    nnoremap L $

    " F1 废弃这个键,防止调出系统帮助
    " I can type :help on my own, thanks.  Protect your fat fingers from the evils of <F1>
    noremap <F1> <Esc>"

    set clipboard=unnamed

endfunction

" function! customize#after() abort 
"     let g:airline_theme='onehalfdark'
" endfunction
