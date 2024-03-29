require("plugins")
require("mappings")

local session_file=vim.fn.stdpath('config').."/Session.vim"

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end
function autosaveSession()
  --if (vim.fn.argc()==0) then

    if file_exists(session_file) then
    local cmd_string=""
    cmd_string=cmd_string.."source " .. session_file
    
    for i, File in ipairs(vim.fn.argv()) do
    if i>0 then
      cmd_string=cmd_string.." | "..[[edit ]]..File..[[]] -- This makes sure that the files opened are the last ones displayed
    end
      end
   vim.cmd(cmd_string)
    end
  
  
  vim.loop.new_timer():start(0,500,vim.schedule_wrap(function()
    os.remove(session_file)
    vim.cmd("silent! argd* | " .. "mksession! "..session_file) -- The argd is needed, else even if you delete a buffer, if you passed it in as an argument, it will be restored anyway
  end))
  
end

vim.cmd([[autocmd VimEnter * nested lua autosaveSession() ]]) -- Reload session when starting with no arguments
--vim.cmd([[autocmd VimEnter * startinsert!]])
vim.cmd([[autocmd CursorHoldI * doautocmd CursorHold]]) -- Since I rarely leave Insert, manually fire the CursorHold event every once in a while

vim.cmd([[set updatetime=400]])

vim.cmd("set sessionoptions=blank,folds,help,tabpages,winsize")
--vim.cmd("autocmd BufDelete * if len(filter(range(1, bufnr('$')), '! empty(bufname(v:val)) && buflisted(v:val)')) == 1 | quit | endif") -- Quit if there's no more buffers left
vim.cmd("set nohidden") --required to prevent the creation of "[No Name]" buffers


vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*", callback = function() vim.diagnostic.config({ signs = false, }) end }) 
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", callback = function() vim.diagnostic.config({ signs = true, }) vim.cmd("TroubleClose") end })

vim.diagnostic.config({virtual_text = false})
