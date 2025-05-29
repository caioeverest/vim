-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<C-\\>', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { 'LG', ':Neotree float git_status<CR>', desc = 'NeoTree git status', silent = true },
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      window = {
        position = 'right',
        mappings = {
          ['<C-\\>'] = 'close_window',
        },
      },
    },
  },
}
