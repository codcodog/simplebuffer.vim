let s:save_cpo = &cpo
set cpo&vim

if !exists("g:botright_height")
    let g:simple_botright_height = 10
endif

" commands
command! SimpleBuffer call simplebuffer#OpenSimpleBuffer()
command! SimpleBufferClose call simplebuffer#CloseSimpleBuffer()
command! SimpleBufferToggle call simplebuffer#ToggleSimpleBuffer()

let &cpo = s:save_cpo
unlet s:save_cpo
