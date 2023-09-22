-- nvim_tree.lua

local function opts(desc)
	return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

local function my_on_attach(bufnr)
	local api = require "nvim-tree.api"

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
	vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { -- optional packages
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local api = require "nvim-tree.api"
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			renderer = {
				group_empty = true,
			},
			git = { ignore = true },
			filters = {
				dotfiles = true,
				custom = {'.git'},
			},
			actions = {
				open_file = {
					quit_on_open = false, -- don't close when opening file
				},
			},
			view = {
				side = 'left',
				width = 30,
				adaptive_size = true,
			},
		})
		vim.keymap.set('n', '\\\\', api.tree.toggle, { silent = true, nowait = true })
		vim.keymap.set('n', 'LF', '<cmd>NvimTreeFindFile<cr>', { silent = true, nowait = true })
		vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
	end,
	on_attach = my_on_attach,
}
