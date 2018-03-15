let s:save_cpo = &cpo
set cpo&vim

function! s:StrAdjust(str, width, direction)
    let astr = ''
    if strlen(a:str) >= a:width
        let astr .= a:str
    else
        let diff = a:width - strlen(a:str)
        if a:direction ==# 'right'
            let astr .= repeat(' ', diff).a:str
        elseif a:direction ==# 'left'
            let astr .= a:str.repeat(' ', diff)
        else
            let diff = float2nr(diff)
            let astr .= repeat(' ', diff).a:str.repeat(' ', diff)
        endif
    endif

    return astr
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
            let bmod  = ' +'
        else
            let bmod = '  '
        endif

        if flag
            let flag = v:false
            call setline(1, s:StrAdjust(bnr, 3, 'right').s:StrAdjust(bhid, 6, 'right').bmod.repeat(' ', 3).bname)
        else
            call append(line('$'), s:StrAdjust(bnr, 3, 'right').s:StrAdjust(bhid, 6, 'right').bmod.repeat(' ', 3).bname)
        endif
    endfor

    setlocal nomodifiable
endfunction

function! s:SelectBuf()
    let content = getline(line('.'))
    let bufnr = str2nr(strpart(content, 0, 3))

    return bufnr
endfunction

function! s:DelBuf()
    let bufnr = s:SelectBuf()
    let prebufnr = getbufvar('%', 'nowbufnr')

    if winnr('$') == 2 && bufwinnr(bufnr) == 1
        exe '1wincmd w'
        exe 'silent! bn'

        let nowbufnr = winbufnr(1)

        exe '2wincmd w'
        call setbufvar('%', 'nowbufnr', nowbufnr)
    endif
    
    exe "bdelete ".bufnr

    if bufnr == prebufnr
        let lastwinnr = winnr('$')

        if lastwinnr == 2
            call setbufvar('%', 'prewinnr', 1)
        else
            let nowwinnr = lastwinnr - 1
            call setbufvar('%', 'prewinnr', nowwinnr)
       endif
    endif

    if empty(getbufinfo({'buflisted': 1}))
        quit
    else
        call s:ListBuffers()
    endif
endfunction

function! s:WipeBuf()
    let bufnr = s:SelectBuf()

    if winnr('$') == 2 && bufwinnr(bufnr) == 1
        exe '1wincmd w'
        exe 'silent! bn'

        let nowbufnr = winbufnr(1)

        exe '2wincmd w'
        call setbufvar('%', 'nowbufnr', nowbufnr)
    endif

    exe "bwipeout ".bufnr

    if empty(getbufinfo({'buflisted': 1}))
        quit
    else
        call s:ListBuffers()
    endif
endfunction

function! s:EnterBuf()
    let bufnr = s:SelectBuf()
    let prewinnr = getbufvar('%', 'prewinnr')

    quit
    exe prewinnr.'wincmd w'
    exe 'silent! buffer'.bufnr
endfunction

function! s:CloseBuf()
    let prewinnr = getbufvar('%', 'prewinnr')
    let winnr = bufwinnr('^simplebuffer$')

    if winnr > 0
        quit
    endif

    exe 'silent! '.prewinnr.'wincmd w'
endfunction

function! s:OpenBuf(direction)
    let bufnr = s:SelectBuf()
    let prewinnr = getbufvar('%', 'prewinnr')

    if a:direction ==# 'horizon'
        quit
        exe prewinnr.'wincmd w'
        exe 'silent! belowright sb '.bufnr
    elseif a:direction ==# 'vertical'
        quit
        exe prewinnr.'wincmd w'
        exe 'silent! vertical belowright sb '.bufnr
    endif
endfunction

function! s:MapKeys()
    noremap <silent> <buffer> <C-v> :call <SID>OpenBuf('vertical')<CR>
    noremap <silent> <buffer> <C-x> :call <SID>OpenBuf('horizon')<CR>
    noremap <silent> <buffer> d :call <SID>DelBuf()<CR>
    noremap <silent> <buffer> D :call <SID>WipeBuf()<CR>
    noremap <silent> <buffer> <Enter> :call <SID>EnterBuf()<CR>
    noremap <silent> <buffer> <ESC> :call <SID>CloseBuf()<CR>
    noremap <silent> <buffer> q :call <SID>CloseBuf()<CR>
endfunction

function! simplebuffer#OpenSimpleBuffer()
    let winnr = bufwinnr('^simplebuffer$')
    let nowbuf = bufnr('%')
    let prewinnr = winnr()

    if winnr < 0
        exe "keepalt botright silent! ".g:simple_botright_height."new simplebuffer"

        setlocal hidden
        setlocal buftype=nofile
        setlocal nobuflisted
        setlocal nonumber
        setlocal cursorline
        setlocal filetype=simplebuffer
        setlocal nomodifiable

        call setbufvar('%', 'nowbufnr', nowbuf)
        call setbufvar('%', 'prewinnr', prewinnr)
        call s:ListBuffers()
        call s:MapKeys()
    else
        exe winnr . 'wincmd w'
    endif
endfunction

function! simplebuffer#ToggleSimpleBuffer()
    let winnr = bufwinnr('^simplebuffer$')

    if winnr < 0
        call simplebuffer#OpenSimpleBuffer()
    else
        call simplebuffer#CloseSimpleBuffer()
    endif
endfunction

function! simplebuffer#CloseSimpleBuffer()
    call s:CloseBuf()
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
