return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    local bufferline = require('bufferline')
    bufferline.setup{
      highlights = {},
      options = {
        mode                         = "tabs", -- set to "tabs" to only show tabpages instead
        style_preset                 = bufferline.style_preset.minimal,
        diagnostics                  = "nvim_lsp",
        offsets                      = {{filetype = "NvimTree", text = "File Explorer"}},
        show_tab_indicators          = true,
        enforce_regular_tabs         = true,
        always_show_bufferline       = false,
        sort_by                      = 'id',
        buffer_close_icon            = '✖',
        modified_icon                = '☜',
        indicator                    = { style = 'underline' },
        hover                        = {
          enabled = true,
          delay   = 200,
          reveal  = {'close'}
        }
      },
    }
  end
}
