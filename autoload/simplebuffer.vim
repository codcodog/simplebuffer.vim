let s:save_cpo = &cpo
set cpo&vim

function! s:ListBuffers()
    setlocal modifiable
    silent! normal! gg"_dG

    let flag = v:true
    for buf in getbufinfo({'buflisted': 1})
        let bnr = buf.bufnr
        let bname = bufname(bnr)

        if flag
            let flag=v:false
            call setline(1, repeat(' ', 2).bnr.repeat(' ', 4).bname)
        else
            call append(line('$'), repeat(' ', 2).bnr.repeat(' ', 4).bname)
        endif

    endfor

    setlocal nomodifiable
endfunction

function! simplebuffer#OpenSimpleBuffer()
    let prenr = winnr()
    let winnr = bufwinnr('^simplebuffer$')

    if winnr < 0
        keepalt botright silent! 10new simplebuffer

        setlocal hidden
        setlocal buftype=nofile
        setlocal nobuflisted
        setlocal nonumber
        setlocal cursorline
        setlocal filetype=simplebuffer
        setlocal nomodifiable

        call s:ListBuffers()
    else
        exe winnr . 'wincmd w'
    endif
endfunction

function! simplebuffer#CloseSimpleBuffer()
    echo 'close'
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
