local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug("kamykn/spelunker.vim")
	
Plug('pocco81/auto-save.nvim')

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', {['tag']= '0.1.6'})

Plug('lervag/vimtex')

Plug("folke/trouble.nvim")

vim.call('plug#end')

vim.cmd([[let g:spelunker_check_type = 2]])
vim.cmd([[let g:spelunker_highlight_type = 2]])
vim.cmd("let g:enable_spelunker_vim = 0")

vim.cmd([[
augroup spelunkerFileTypeSwitch
    autocmd!
    autocmd BufNewFile,BufRead *.txt,*.md let b:enable_spelunker_vim = 1
augroup END
]])
require("auto-save").setup{
	trigger_events={"TextChangedI","TextChanged"}
}

require("telescope").setup{
  defaults={
  path_display={absolute}
}
}

vim.cmd([[let g:vimtex_compiler_enabled=0]])

require("trouble").setup{
    icons = false,
    fold_open = "v", -- icon used for open folds
    fold_closed = ">", -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
    signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
    },
    use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
}