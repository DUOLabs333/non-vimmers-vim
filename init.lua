require("lsp")
require("plugins")
require("mappings")

local session_file=vim.fn.stdpath('config').."/Session.vim"

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end
function autosaveSession()
  --if (vim.fn.argc()==0) then

  if (true) then
    if file_exists(session_file) then
    vim.cmd("source " .. session_file)
    end
  end
  
  vim.loop.new_timer():start(0,500,vim.schedule_wrap(function()
    vim.cmd("mksession! "..session_file)
  end))
  
end

vim.cmd([[autocmd VimEnter * nested lua autosaveSession() ]]) -- Reload session when starting with no arguments
vim.cmd([[autocmd VimEnter * startinsert!]])
vim.cmd([[autocmd CursorHoldI * doautocmd CursorHold]]) -- Since I rarely leave Insert, manually fire the CursorHold event every once in a while

vim.cmd([[set updatetime=400]])
vim.cmd("set sessionoptions-=options")
vim.cmd("set sessionoptions-=localoptions")
vim.cmd("set sessionoptions+=globals")
--vim.cmd("autocmd BufDelete * if len(filter(range(1, bufnr('$')), '! empty(bufname(v:val)) && buflisted(v:val)')) == 1 | quit | endif") -- Quit if there's no more buffers left


