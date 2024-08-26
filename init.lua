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
