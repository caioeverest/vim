-- golang.lua

return {
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
		.make_client_capabilities())
		require("go").setup({
			goimport            = 'gopls', -- if set to 'gopls' will use golsp format
			gofmt               = 'gopls', -- if set to gopls will use golsp format
			max_line_len        = 120,
			tag_transform       = false,
			comment_placeholder = 'ﳑ',
			lsp_cfg             = true, -- false: use your own lspconfig
			lsp_gofumpt         = true, -- true: set default gofmt in gopls format to gofumpt
			lsp_on_attach       = true, -- use on_attach from go.nvim
			dap_debug           = true,
		})
		lsp_cfg = { capabilities = capabilities }
		local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require('go.format').goimport()
			end,
			group = format_sync_grp,
		})
	end,
	event = { "CmdlineEnter" },
	ft = { "go", 'gomod' },
	build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
