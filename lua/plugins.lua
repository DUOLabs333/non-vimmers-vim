local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug("kamykn/spelunker.vim")
	
Plug('pocco81/auto-save.nvim')

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', {['tag']= '0.1.6'})

Plug('lervag/vimtex')

Plug("folke/trouble.nvim")

Plug("farmergreg/vim-lastplace")

Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/nvim-cmp')
vim.call('plug#end')

-----------Spell Check---------------------
vim.cmd([[let g:spelunker_check_type = 2]])
vim.cmd([[let g:spelunker_highlight_type = 2]])
vim.cmd("let g:enable_spelunker_vim = 0")

vim.cmd([[
augroup spelunkerFileTypeSwitch
    autocmd!
    autocmd BufNewFile,BufRead *.txt,*.md let b:enable_spelunker_vim = 1
augroup END
]])


------Auto Save------------------------
require("auto-save").setup{
	trigger_events={"TextChangedI","TextChanged"},
	condition = function(buf)
		local fn = vim.fn
		local utils = require("auto-save.utils.data")

		if
			fn.getbufvar(buf, "&modifiable") == 1 and
			utils.not_in(fn.getbufvar(buf, "&filetype"), {}) and (vim.fn.empty(vim.fn.glob(vim.fn.expand("%:p")))==0) then -- Check that file exists, so we don't accidentally create a file by using a buffer as scratch
			return true -- met condition(s), can save
		end
		return false -- can't save
	end,
}


----Opening Buffers-----------------------------------


require("telescope").setup{
  defaults={
  path_display={absolute}, 
}}

-------LaTex-------------------------
vim.cmd([[let g:vimtex_compiler_enabled=0]])

--------------LSP------------------------
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

---------Autocompletion-----------------------

local cmp = require('cmp')

  cmp.setup({
       enabled= true,
       snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<C-p>"] = cmp.config.disable,
      ["<C-n>"] = cmp.config.disable,
    }),
    sources = cmp.config.sources({{ name = 'nvim_lsp' }}, {{ name = 'buffer' }}
    )
  })

  cmp.setup.filetype("text", {
	  sources=cmp.config.sources({{ name = 'buffer' }})
	})
 cmp.setup.filetype("gitcommit", {
	  enabled= false
	})
   
