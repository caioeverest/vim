-- plantuml.lua

return {
  'https://gitlab.com/itaranto/plantuml.nvim',
  dependencies = {
    'aklt/plantuml-syntax',
  },
  version = '*',
  config = function() require('plantuml').setup({
    renderer = {
      type = 'image',
      options = {
	prog = 'feh',
      }
    },
    render_on_write = true,
  }) end,
}

