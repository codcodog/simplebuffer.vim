let s:save_cpo = &cpo
set cpo&vim

function! s:StrAdjust(str, width, direction)
endfunction

function! s:BufMode(bnr)
    let mod = ''

    if getbufvar('%', 'nowbufnr') == a:bnr
        let mod .= '%'
    elseif bufnr('#') == a:bnr
        let mod .= '#'
    endif

    return mod
endfunction

function! s:ListBuffers()
    setlocal modifiable
    silent! normal! gg"_dG

    let flag = v:true
    for buf in getbufinfo({'buflisted': 1})
        let bnr = buf.bufnr
        let bname = bufname(bnr)

        if buf.hidden
            let bhid = s:BufMode(bnr) . 'h'
        else
            let bhid = s:BufMode(bnr) . 'a'
        endif

        if getbufvar(bnr, '&modified')
            let bhid  .= ' +'
        endif

        if flag
            let flag = v:false
            call setline(1, repeat(' ', 2).bnr.repeat(' ', 4).bhid.repeat(' ', 4).bname)
        else
            call append(line('$'), repeat(' ', 2).bnr.repeat(' ', 4).bhid.repeat(' ', 4).bname)
        endif
    endfor

    setlocal nomodifiable
endfunction

function! simplebuffer#OpenSimpleBuffer()
    let prenr = winnr()
    let winnr = bufwinnr('^simplebuffer$')
    let nowbuf = bufnr('%')

    if winnr < 0
        keepalt botright silent! 10new simplebuffer

        setlocal hidden
        setlocal buftype=nofile
        setlocal nobuflisted
        setlocal nonumber
        setlocal cursorline
        setlocal filetype=simplebuffer
        setlocal nomodifiable

        call setbufvar('%', 'nowbufnr', nowbuf)
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
