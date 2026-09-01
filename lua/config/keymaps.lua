-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Add a quick save shortcut
vim.keymap.set('n', '<leader>w', '<cmd>:w<cr>', { silent = true })

-- Opens a new tab
vim.keymap.set('n', 'nt', '<cmd>tabnew<cr>', { silent = true })

-- Tab movement
vim.keymap.set('n', '<S-Tab>', ':tabprevious<cr>', { silent = true })
vim.keymap.set('n', '<Tab>', ':tabnext<cr>', { silent = true })

-- Ctrl+g to duplicate visual selection
vim.keymap.set('v', '<C-d>', "y'>p", { silent = true })

-- Encode base64
vim.keymap.set('v', '<leader>64e', 'c<c-r>=system("base64", @")<cr><esc>', { silent = true })
-- Decode base64
vim.keymap.set('v', '<leader>64d', 'c<c-r>=system("base64 --decode", @")<cr><esc>', { silent = true })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]resume' })

-- Copy path of the current buffer or Neo-tree selection to clipboard
local function copy_path(opts)
  local relative = opts ~= nil and opts.args == 'relative'
  local path

  if vim.bo.filetype == 'neo-tree' then
    local state = require('neo-tree.sources.manager').get_state_for_window()
    local node = state and state.tree and state.tree:get_node()
    path = node and node.path
  else
    path = vim.api.nvim_buf_get_name(0)
  end

  if path == nil or path == '' or vim.fn.isdirectory(path) == 1 then
    vim.notify('No file selected', vim.log.levels.WARN)
    return
  end

  path = vim.fn.fnamemodify(path, relative and ':.' or ':p')
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path)
end

vim.api.nvim_create_user_command('CopyPath', copy_path, {
  desc = 'Copy the current buffer or Neo-tree selection path (absolute)',
  nargs = '?',
  complete = function(arg)
    return vim.tbl_filter(function(item)
      return item:find(arg, 1, true) == 1
    end, { 'relative' })
  end,
})

vim.keymap.set('n', '<leader>fp', ':CopyPath relative<cr>', {
  desc = 'Copy relative file path',
  silent = true,
})
vim.keymap.set('n', '<leader>fP', ':CopyPath<cr>', {
  desc = 'Copy absolute file path',
  silent = true,
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1 }
end, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1 }
end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.diagnostic.config { update_in_insert = true }
