let s:save_cpo = &cpo
set cpo&vim

function! s:ListBuffers()
endfunction

function! simplebuffer#OpenSimpleBuffer(bang)
    echo 'open'
endfunction

function! simplebuffer#CloseSimpleBuffer(bang)
    echo a:bang
    echo 'close'
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
