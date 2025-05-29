-- lualine.lua

return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto',
        component_separators = '|',
        -- section_separators = { left = '', right = '' },
      },
      sections = {
        -- lualine_a = {
        -- 	{ 'mode', separator = { left = '' }, right_padding = 2 },
        -- },
        lualine_b = { 'filename', 'branch' },
        lualine_c = { 'fileformat' },
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        -- lualine_z = {
        -- 	{ 'location', separator = { right = '' }, left_padding = 2 },
        -- },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    }
  end,
  optional = true,
  event = 'VeryLazy',
  opts = function(_, opts)
    table.insert(
      opts.sections.lualine_x,
      2,
      LazyVim.lualine.status(LazyVim.config.icons.kinds.Copilot, function()
        local clients = package.loaded['copilot'] and LazyVim.lsp.get_clients { name = 'copilot', bufnr = 0 } or {}
        if #clients > 0 then
          local status = require('copilot.api').status.data.status
          return (status == 'InProgress' and 'pending') or (status == 'Warning' and 'error') or 'ok'
        end
      end)
    )
  end,
}
