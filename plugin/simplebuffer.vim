let s:save_cpo = &cpo
set cpo&vim

" commands
command! -bang SimpleBuffer call simplebuffer#OpenSimpleBuffer('<bang>')
command! -bang SimpleBufferClose call simplebuffer#CloseSimpleBuffer('<bang>')

let &cpo = s:save_cpo
unlet s:save_cpo
