-- autopairs.lua

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- No nvim-cmp integration: completion is handled by blink.cmp, which manages
  -- its own bracket behaviour.
  opts = {},
}
