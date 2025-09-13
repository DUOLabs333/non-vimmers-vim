local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug("rmagatti/auto-session")

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', {['tag']= '0.1.6'})

Plug('lervag/vimtex')

Plug("folke/trouble.nvim")
Plug("lewis6991/hover.nvim")

Plug("farmergreg/vim-lastplace")

Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/nvim-cmp')

Plug('mhinz/vim-signify')

Plug('nvim-tree/nvim-web-devicons')
Plug('lewis6991/gitsigns.nvim')
Plug('romgrk/barbar.nvim')

Plug("neovim/nvim-lspconfig")
Plug("sontungexpt/better-diagnostic-virtual-text")

Plug('nvim-treesitter/nvim-treesitter')

vim.call('plug#end')
vim.cmd("filetype indent off")  -- Apparent vim-plug turns it on by default

------Auto Save------------------------
--[[
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
]]--
----Opening Buffers-----------------------------------

require("telescope").setup{
  defaults={
  path_display={absolute},
  mappings = {
    i = {
      ["<esc>"] = function(prompt_bufnr)
      require('telescope.actions').close(prompt_bufnr)
      	vim.cmd([[normal! i]])
	end
    },
  }
  },
  pickers = {
    buffers = {
      attach_mappings = function()
        require("telescope.actions.set").select:enhance({ -- So buffers are entered in Insert mode
          post = function()
            vim.schedule(function()
              vim.cmd([[startinsert]])
            end)
          end,
        })
        return true
      end,
      sort_lastused = true
    },
  },
}

-------LaTex-------------------------
vim.cmd([[let g:vimtex_quickfix_ignore_filters = ['Warning:', 'Overfull'] ]])
vim.cmd("let g:vimtex_view_automatic = 0")
vim.cmd("let g:vimtex_quickfix_enabled = 0")

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

require'lspconfig'.jedi_language_server.setup{}
-- require'lspconfig'.typst_lsp.setup{}
require'lspconfig'.tinymist.setup{
	offset_encoding = "utf-8",
	cmd = {"tinymist-linux-arm64"},
	root_dir = function(fname) 
	return vim.env.HOME
	end,

	--settings = {exportPdf = "onSave", typstExtraArgs = {"--input", "TINYMIST_FILEPATH='name'"}},
	
}
require'lspconfig'.clangd.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.pylsp.setup{}

vim.lsp.set_log_level("off")
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
 -- vim.cmd([[hi CmpItemKind guifg=#d79921 guibg=#3c3836]])
 vim.cmd("hi! link CmpItemKind @lsp.type.function.cpp") -- Fixes the "kind" part of the display so that it is now light blue instead of black
-----------------Hover------------------------------
require("hover").setup {
            init = function()
                -- Require providers
                require("hover.providers.lsp")
                -- require('hover.providers.gh')
                -- require('hover.providers.gh_user')
                -- require('hover.providers.jira')
                -- require('hover.providers.man')
                -- require('hover.providers.dictionary')
            end,
            preview_opts = {
                border = 'single'
            },
            -- Whether the contents of a currently open hover window should be moved
            -- to a :h preview-window when pressing the hover keymap.
            preview_window = false,
            title = true,
            mouse_providers = {
                'LSP'
            },
            mouse_delay = 1000
        }


------- Auto-Session ---------------------
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals"
auto_session=require('auto-session')
auto_session.setup {
	pre_save_cmds= {
		function() vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'}) end -- Important, so barbar can maintain buffer order
	}
}
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  callback = function()
	auto_session.SaveSession()
  end,
})


----------BarBar------------
require("barbar").setup({
	    icons = {
	      filetype = {
	        custom_colors = true,
	        enabled = true
	      }
	    }
})
---------Tree-Sitter-------------
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "typst", "cpp" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {  },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {  },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-----------------Copilot
if false then
require("copilot").setup({
panel={
enabled=false
},
suggestion={
enabled=true,
auto_trigger = true,
hide_during_completion = false
},
})
end

