-- Highlight, edit, and navigate code

-- Languages whose parser/queries we want installed and whose treesitter
-- features we enable on FileType.
local languages = {
  'bash',
  'c',
  'diff',
  'go',
  'gomod',
  'gosum',
  'gowork',
  'html',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
  'yaml',
}

local language_set = {}
for _, language in ipairs(languages) do
  language_set[language] = true
end

return {
  'nvim-treesitter/nvim-treesitter',
  -- The `master` branch does not support Neovim 0.12 -- its injection
  -- directives call removed node APIs, which crashes highlighting on any
  -- markdown buffer with fenced code blocks. `main` is the 0.12+ line.
  branch = 'main',
  lazy = false, -- upstream explicitly does not support lazy-loading
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install(languages)

    -- `main` no longer enables features for you; core provides highlight and
    -- folds, nvim-treesitter provides indentation.
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('TreesitterFeatures', { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not lang or not language_set[lang] or not pcall(vim.treesitter.language.add, lang) then
          return
        end

        vim.treesitter.start(args.buf, lang)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
