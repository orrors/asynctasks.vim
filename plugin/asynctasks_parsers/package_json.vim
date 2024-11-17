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
  echo filereadable(s:get_package_path())
  return filereadable(s:get_package_path())
endfunc

function! asynctasks_parsers#package_json#parse(section, object)
  let l:package_tasks = s:load_package_json()

  let new_keys = []
  for key in a:object.keys
    if key == a:section
      for task in l:package_tasks
        call add(new_keys, a:section . ' ' . task)
      endfor
    else
      call add(new_keys, key)
    endif
  endfor
  let a:object.keys = new_keys

  let new_config = {}
  for key in keys(a:object.config)
    if key == a:section
      call remove(a:object.config[key], 'parser')
      if has_key(a:object.config[key], 'command')
        let command = a:object.config[key].command
        for task in l:package_tasks
          let new_key = a:section . ' ' . task
          let new_config[new_key] = deepcopy(a:object.config[key])
          let new_config[new_key].command = command . ' ' . task
        endfor
      endif
    else
      let new_config[key] = a:object.config[key]
    endif
  endfor
  let a:object.config = new_config
endfunc
