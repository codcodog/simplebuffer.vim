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

function! s:Refresh()
    silent! normal! gg"_dG
    call s:ListBuffers()
endfunction

function! s:DelBuf()
    let bufnr = s:SelectBuf()
    exe "bdelete ".bufnr
    call s:Refresh()
endfunction

function! s:WipeBuf()
    let bufnr = s:SelectBuf()
    exe "bwipeout ".bufnr
    call s:Refresh()
endfunction

function! s:MapKeys()
    noremap <silent> <buffer> <C-v> <nop>
    noremap <silent> <buffer> <C-x> <nop>
    noremap <silent> <buffer> d :call <SID>DelBuf()<CR>
    noremap <silent> <buffer> D :call <SID>WipeBuf()<CR>
    noremap <silent> <buffer> <Enter> <nop>
    noremap <silent> <buffer> <ESC> <nop>
endfunction

function! simplebuffer#OpenSimpleBuffer()
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
        call s:MapKeys()
    else
        exe winnr . 'wincmd w'
    endif
endfunction

function! simplebuffer#CloseSimpleBuffer()
    echo 'close'
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
