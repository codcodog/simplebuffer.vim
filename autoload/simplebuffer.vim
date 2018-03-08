let s:save_cpo = &cpo
set cpo&vim

function! s:ListBuffers()
    call setline(1, 'hello world.')
    call setline(2, 'hello world.')
    call setline(3, 'hello world.')
endfunction

function! simplebuffer#OpenSimpleBuffer(bang)
    let prenr = winnr()
    let winnr = bufwinnr('^simplebuffer$')

    if winnr < 0
        keepalt botright silent! 10new simplebuffer

        setlocal hidden
        setlocal nobuflisted
        setlocal nonumber
        setlocal cursorline
        setlocal filetype=simplebuffer

        call s:ListBuffers()
    else
        exe winnr . 'wincmd w'
    endif
endfunction

function! simplebuffer#CloseSimpleBuffer(bang)
    echo 'close'
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
