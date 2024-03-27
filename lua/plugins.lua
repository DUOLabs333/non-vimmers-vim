local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug("kamykn/spelunker.vim")
	
Plug('pocco81/auto-save.nvim')

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', {['tag']= '0.1.6'})

vim.call('plug#end')

vim.cmd([[let g:spelunker_check_type = 2]])
vim.cmd([[let g:spelunker_highlight_type = 2]])

require("auto-save").setup{
	trigger_events={"TextChangedI","TextChanged"}
}



