
function! asynctasks_parsers#package_json#requirements(val)
	let name = asyncrun#get_root('%')
  return filereadable(name . "/" . "package.json")
endfunc

function! asynctasks_parsers#package_json#parse()

endfunc
