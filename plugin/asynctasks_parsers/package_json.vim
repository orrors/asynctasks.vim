function! s:get_package_path() 
	let name = asyncrun#get_root('%')
  return name . "/" . "package.json"
endfun

function! s:load_package_json()
  let json = readfile(s:get_package_path())
  let content = join(json, "\n")
  let tasks = json_decode(content)
  return keys(tasks.scripts)
endfunction

function! asynctasks_parsers#package_json#requirements()
  return filereadable(s:get_package_path())
endfunc

function! asynctasks_parsers#package_json#parse(section)
  echo a:section
  echo s:load_package_json()
endfunc
