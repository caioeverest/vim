-- toggleterm.lua

return {
  'akinsho/toggleterm.nvim',
  config = function()
    local Terminal = require('toggleterm.terminal').Terminal

    -- Define a terminal for running lazygit
    local lazygit = Terminal:new {
      cmd = 'lazygit',
      dir = 'git_dir',
      direction = 'float',
      close_on_exit = false,
      float_opts = {
        border = 'double',
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd 'startinsert!'
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd 'startinsert!'
      end,
    }

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })

    -- Define a terminal for running ctop
    local ctop = Terminal:new {
      cmd = 'ctop',
      dir = 'git_dir',
      direction = 'float',
      float_opts = {
        border = 'double',
      },
      on_open = function(term)
        vim.cmd 'startinsert!'
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
      end,
      on_close = function(term)
        vim.cmd 'startinsert!'
      end,
    }

    function _ctop_toggle()
      ctop:toggle()
    end

    vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua _ctop_toggle()<CR>', { noremap = true, silent = true })

    -- Define a terminal for running claude code
    local claude_code = Terminal:new {
      cmd = 'claude',
      direction = 'vertical',
      close_on_exit = false,
      auto_scroll = true,
      on_open = function(term)
        vim.cmd 'wincmd R' -- Move window to the right
        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-q>', '<cmd>close<CR>', { noremap = true, silent = true })
      end,
      on_close = function(term)
        vim.cmd 'startinsert!'
      end,
    }

    function _claude_code_toggle()
      claude_code:toggle()
    end

    vim.api.nvim_set_keymap('n', '<leader>c', '<cmd>lua _claude_code_toggle()<CR>', { noremap = true, silent = true })

    -- Create a session-specific terminal ID to ensure each vim session gets its own terminal
    local session_terminal_id = vim.fn.getpid()

    -- Override the default terminal toggle to use session-specific terminal
    function _session_terminal_toggle()
      require('toggleterm').toggle(session_terminal_id)
    end

    -- Map <C-]> to use session-specific terminal instead of the default
    vim.api.nvim_set_keymap('n', '<C-]>', '<cmd>lua _session_terminal_toggle()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('t', '<C-]>', '<cmd>lua _session_terminal_toggle()<CR>', { noremap = true, silent = true })

    -- Window mapping
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

    -- Define config
    require('toggleterm').setup {
      shade_filetypes = { 'none' },
      direction = 'horizontal',
      insert_mappings = false,
      start_in_insert = true,
      close_on_exit = false,
      auto_scroll = true,
      persist_size = false,
      persist_mode = true,
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
