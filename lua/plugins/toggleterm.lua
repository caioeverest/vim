-- toggleterm.lua

return {
  'akinsho/toggleterm.nvim',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<C-]>]],
      shade_filetypes = { 'none' },
      direction = 'horizontal',
      insert_mappings = false,
      start_in_insert = true,
      float_opts = { border = 'rounded', winblend = 3 },
      size = function(term)
        if term.direction == 'horizontal' then
          return math.floor(vim.o.lines * 0.3)
        elseif term.direction == 'vertical' then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
    }
  end,
}
