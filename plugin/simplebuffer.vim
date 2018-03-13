let s:save_cpo = &cpo
set cpo&vim

" commands
command! SimpleBuffer call simplebuffer#OpenSimpleBuffer()
command! SimpleBufferClose call simplebuffer#CloseSimpleBuffer()

let &cpo = s:save_cpo
unlet s:save_cpo
