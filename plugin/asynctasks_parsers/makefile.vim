function! s:get_makefile_path()
  let name = asyncrun#get_root('%')
  return name . "/" . "Makefile"
endfun

function! asynctasks_parsers#makefile#requirements()
  return filereadable(s:get_makefile_path())
endfunc

function! asynctasks_parsers#makefile#parse()
  let makefile = readfile(s:get_makefile_path())
  let targets = map(filter(makefile, 'v:val =~ ''^\s*[^:]*:'''), 'matchstr(v:val, ''^\s*\zs[^:]*\ze:'')')
  return targets
endfunc
