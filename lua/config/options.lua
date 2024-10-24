-- [[ Setting options ]]

-- Set highlight on search
vim.o.hlsearch = true

-- Makes search behave like in browsers
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true

-- Do not wrap code in any circumstance
vim.wo.wrap = false

-- Highlight current line - allows you to track cursor position more easily
vim.wo.cursorline = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Allow smarter completion by infering the case
vim.o.infercase = true

-- Don't redraw while executing macros (good performance config)
vim.o.lazyredraw = true

-- For regular expressions turn magic one
vim.o.magic = true

-- Enable Ctrl-A/Ctrl-X to work on octal and hex numbers, as well as characters
vim.o.nrformats = 'octal,hex,alpha'

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
