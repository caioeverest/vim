-- Easy align

return {
	'junegunn/vim-easy-align',
	config = function ()
		vim.keymap.set({'n', 'x'}, 'ga', ':EasyAlign<cr>', {silent = true, nowait = true})
	end
}
