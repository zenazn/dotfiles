fu! s:init()
  windo let w:tagstack = []
endfu

fu! s:win_leave()
  let g:laststack = w:tagstack
endfu

fu! s:win_enter()
  if !exists("g:laststack")
    let g:laststack = []
  end
  if !exists("w:tagstack")
    let w:tagstack = copy(g:laststack)
  end
endfu

fu! tag#drill()
  let l:buf = bufnr("%")
  let l:view = winsaveview()
  let l:tag = {"buf": l:buf, "view": l:view}
  call add(w:tagstack, l:tag)
endfu

fu! tag#pop()
  if !len(w:tagstack)
    " Tee hee
    echohl ErrorMsg | echo "E73: tag stack empty" | echohl None
    return
  end

  let l:tag = remove(w:tagstack, -1)
  execute ":buffer " . l:tag["buf"]
  call winrestview(l:tag["view"])
endfu

augroup faketag
  au!
  au VimEnter * call s:init()
  au WinLeave * call s:win_leave()
  au WinEnter * call s:win_enter()
augroup END
