return {
  'caioeverest/excalidraw.nvim',
  cmd = { 'ExcalidrawOpen', 'ExcalidrawCreate', 'ExcalidrawStatus', 'ExcalidrawStop' },
  event = { 'BufReadPre *.excalidraw', 'BufReadPre *.excalidraw.json' },
  keys = {
    { '<leader>xo', '<cmd>ExcalidrawOpen<cr>', desc = 'Excalidraw: Open in browser' },
    { '<leader>xn', '<cmd>ExcalidrawCreate<cr>', desc = 'Excalidraw: Create new file' },
    { '<leader>xs', '<cmd>ExcalidrawStatus<cr>', desc = 'Excalidraw: Server status' },
    { '<leader>xq', '<cmd>ExcalidrawStop<cr>', desc = 'Excalidraw: Stop server' },
  },
  opts = {
    auto_open = false,
    theme = 'auto',
  },
}
