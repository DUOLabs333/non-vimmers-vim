local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug("kamykn/spelunker.vim")
	
Plug('pocco81/auto-save.nvim')

Plug('zefei/vim-wintabs')
Plug('zefei/vim-wintabs-powerline')

Plug('xolox/vim-session')
Plug('xolox/vim-misc')

vim.call('plug#end')

vim.cmd([[let g:spelunker_check_type = 2]])
vim.cmd([[let g:spelunker_highlight_type = 2]])

require("auto-save").setup{
	trigger_events={"TextChangedI","TextChanged"}
}

vim.cmd([[let g:session_directory="]]..vim.fn.stdpath("data")..[[/sessions/"]])
