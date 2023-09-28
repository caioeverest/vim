-- Autocompletion
-- [[ Configure nvim-cmp ]]
-- See `:help cmp`

return  {
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
  },
  config = function ()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup {
      sources = {
	{ name = 'copilot' },
	{ name = 'nvim_lsp' },
	{ name = "buffer" },
	{ name = 'luasnip' },
      },
      snippet = {
	expand = function(args)
	  luasnip.lsp_expand(args.body)
	end,
      },
      mapping = cmp.mapping.preset.insert {
	['<C-n>'] = cmp.mapping.select_next_item(),
	['<C-p>'] = cmp.mapping.select_prev_item(),
	['<C-d>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-Space>'] = cmp.mapping.complete {},
	['<CR>'] = cmp.mapping.confirm {
	  behavior = cmp.ConfirmBehavior.Replace,
	  select = true,
	},
	['<Tab>'] = cmp.mapping(function(fallback)
	  if cmp.visible() then
	    cmp.select_next_item()
	  elseif luasnip.expand_or_locally_jumpable() then
	    luasnip.expand_or_jump()
	  else
	    fallback()
	  end
	end, { 'i', 's' }),
	['<S-Tab>'] = cmp.mapping(function(fallback)
	  if cmp.visible() then
	    cmp.select_prev_item()
	  elseif luasnip.locally_jumpable(-1) then
	    luasnip.jump(-1)
	  else
	    fallback()
	  end
	end, { 'i', 's' }),
      },
      formatting = {
	fields = { "kind", "abbr", "menu" },
	format = function(entry, vim_item)
	  if vim.tbl_contains({ 'path' }, entry.source.name) then
	    local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
	    if icon then
	      vim_item.kind = icon
	      vim_item.kind_hl_group = hl_group
	      return vim_item
	    end
	  end
	  local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
	  local strings = vim.split(kind.kind, "%s", { trimempty = true })
	  kind.kind = " " .. (strings[1] or "") .. " "
	  kind.menu = "    [" .. (strings[2] or "") .. "]"
	  return kind
	end
      },
      window = {
	preselect = require('cmp').PreselectMode.None,
	completion = {
	  autocomplete = false,
	  completeopt = 'menu,menuone,noinsert,noselect',
	  winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
	},
	documentation = cmp.config.window.bordered {
	  border = "rounded",
	  winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
	  max_width = 50,
	  min_width = 50,
	  max_height = math.floor(vim.o.lines * 0.4),
	  min_height = 3,
	}
      }
    }
  end
}




