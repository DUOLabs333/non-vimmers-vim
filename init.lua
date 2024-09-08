require("plugins")
require("mappings")

function vimInit()
    vim.cmd([[let @/ = ""]]) -- Initialize the search register to the empty string
    vim.cmd("highlight Pmenu ctermbg=black")
    vim.cmd("highlight Pmenu ctermfg=white")

    vim.cmd("set whichwrap+=<,>,[,]")  

end

vim.cmd([[autocmd VimEnter * nested lua vimInit() ]]) -- Reload session when starting with no arguments
vim.cmd([[autocmd VimEnter * startinsert!]]) -- Start in insert
vim.cmd([[autocmd CursorHoldI * doautocmd CursorHold]]) -- Since I rarely leave Insert, manually fire the CursorHold event every once in a while

vim.cmd([[set updatetime=400]]) -- Decrease the update time, so events are more responsive

--vim.cmd("autocmd BufDelete * if len(filter(range(1, bufnr('$')), '! empty(bufname(v:val)) && buflisted(v:val)')) == 1 | quit | endif") -- Quit if there's no more buffers left


vim.cmd("set nohidden") --required to prevent the creation of "[No Name]" buffers

vim.diagnostic.config({ signs = true, update_in_insert=true, virtual_text=false}) -- Update on file change in insert mode, show the error/warning icon on the left hand sign, but do not show the error itself in insert mode (it gets distracting)

vim.cmd([[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif " notification after file change autocmd FileChangedShellPost * \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]]) -- Automatically update file if it has been changed by an external process

vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- Disable auto-comment on <CR>
vim.cmd([[
set linebreak
set number
]])

if false then -- Two different implementations of LSP diagnostics
	vim.o.updatetime = 100
	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	  group = vim.api.nvim_create_augroup("float_diagnostic", { clear = false }),
	  callback = function ()
	    vim.diagnostic.open_float(nil, {focus=false})
	  end
	})
else

	vim.api.nvim_create_autocmd("LspAttach", {
		callback=function(args)
			require("better-diagnostic-virtual-text.api").setup_buf(args.buf, {})
		end
	})
end

vim.cmd("hi Todo guifg=Yellow")

vim.cmd("hi SpellBad gui=underline guifg=grey")
vim.cmd("hi SpellLocal gui=underline")
vim.cmd("set spell spelllang=en_us")


vim.cmd([[autocmd BufEnter *.tex VimtexCompile]])

local function serialize(t)
  local serializedValues = {}
  local value, serializedValue
  for i=1,#t do
    value = t[i]
    serializedValue = type(value)=='table' and serialize(value) or value
    table.insert(serializedValues, serializedValue)
  end
  return string.format("{ %s }", table.concat(serializedValues, ', ') )
end

local function getDirectoryFromPath(path)
    -- Remove trailing slash if present
    path = path:gsub("/$", "")
    
    -- Split the path into components
    local components = {}
    for component in path:gmatch("[^/]+") do
        table.insert(components, component)
    end

    -- If there are at least two components (root and one directory),
    -- return the second-to-last component
    if #components >= 2 then
        return components[#components - 1]
    else
        return nil  -- or you could return an empty string ""
    end
end

local function getFileNameWithoutExtension(path)
    -- Extract the file name with extension
    local fileName = path:match("([^/]+)$")
    
    -- If no file name found, return nil
    if not fileName then
        return nil
    end
    
    -- Remove the extension
    local nameWithoutExtension = fileName:match("(.+)%..+")
    
    -- If there was no extension, return the original file name
    return nameWithoutExtension or fileName
end

vim.api.nvim_create_autocmd({"BufWritePost"}, {
	pattern = {"*.typ"},
	callback = function(ev)
		
		vim.notify("BufEnter autocmd fired!")
		local full_path=vim.api.nvim_buf_get_name(ev.buf)
		--local full_path=ev.file


		local write_location=full_path:gsub("%.typ$", ".pdf")

		local directory = getDirectoryFromPath(full_path)

		local file = getFileNameWithoutExtension(full_path)
		
		vim.cmd(string.format([[silent exec "!typst compile \"%s\" --root ~ --input FILE_PATH=\"%s\" --input FILE_DIR=\"%s\" \"%s\" &"]], full_path, file, directory, write_location))

	end
})


vim.api.nvim_create_autocmd({"TextChangedI","TextChanged"},{
	nested = true,
	callback = function(ev)
		local buf = ev.buf

		if (vim.fn.empty(vim.api.nvim_buf_get_name(0)) == 0) and (vim.fn.getbufvar(buf, "&modifiable") == 1) then
			vim.cmd(string.format("%i,%ibufdo! :w", buf, buf))
		end
	end
})
