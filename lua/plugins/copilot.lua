return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  build = ':Copilot auth',
  event = 'BufReadPost',
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = false,
      trigger_on_accept = true,
      keymap = {
        accept = '<C-l>',
        accept_word = false,
        accept_line = false,
        next = '<C-.>',
        prev = '<C-,>',
        dismiss = '<C-]>',
      },
    },
  },
}
