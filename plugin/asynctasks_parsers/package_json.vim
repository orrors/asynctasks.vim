function! s:get_package_path()
  let name = asyncrun#get_root('%')
  return name . "/" . "package.json"
endfun

function! asynctasks_parsers#package_json#requirements()
  return filereadable(s:get_package_path())
endfunc

function! asynctasks_parsers#package_json#parse()
  let json = readfile(s:get_package_path())
  let tasks = json_decode(json)
  return keys(tasks.scripts)
endfunc
