-- golang.lua

local nmap = function(keys, func, desc)
	if desc then
		desc = 'LSP: ' .. desc
	end
	vim.keymap.set('n', keys, func, { desc = desc })
end

local config = function ()
	local capabilities    = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
	local api             = require("go")
	local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})

	api.setup({
		goimport            = 'gopls', -- if set to 'gopls' will use golsp format
		gofmt               = 'gopls', -- if set to gopls will use golsp format
		max_line_len        = 120,
		tag_transform       = false,
		comment_placeholder = 'ﳑ',
		lsp_cfg             = { capabilities = capabilities },
		lsp_gofumpt         = true, -- true: set default gofmt in gopls format to gofumpt
		lsp_on_attach       = true,
		dap_debug           = true,
	})
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		callback = function()
			require('go.format').goimport()
		end,
		group = format_sync_grp,
	})
	nmap('<leader>rn', ':GoRename<cr>', '[R]e[n]ame')
	nmap('<leader>at', ':GoAddTag<cr>', '[A]dd[T]ags')
	nmap('<leader>rt', ':GoRmTag<cr>', '[R]emove[T]ags')

	nmap('<leader>fst', ':GoFillStruct<cr>', '[F]ill[S][T]ruct')
	nmap('<leader>fsw', ':GoFillSwitch<cr>', '[F]ill[S][W]itch')
	nmap('<leader>aer', ':GoIfErr<cr>', '[A]dd[E]rror')

	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
	nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

end

return {
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = config,
	event = { "CmdlineEnter" },
	ft = { "go", 'gomod' },
	build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
