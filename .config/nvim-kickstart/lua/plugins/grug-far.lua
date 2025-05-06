return {
  'MagicDuck/grug-far.nvim',
  dependencies = { 'nvim-web-devicons' }, -- Optional for icons
  -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
  -- additional lazy config to defer loading is not really needed...
  config = function()
    vim.g.maplocalleader = ','
    -- optional setup call to override plugin options
    -- alternatively you can set options with vim.g.grug_far = { ... }
    require('grug-far').setup {
      vim.keymap.set('n', '<leader>gf', function()
        require('grug-far').open { instanceName = 'my_precious' }
      end, { desc = 'Grug far' }),

      vim.keymap.set('n', '<leader>gf', function()
        require('grug-far').toggle_instance()
      end, { desc = 'Grug far' }),
      -- options, see Configuration section below
      -- there are no required options atm
      -- engine = 'ripgrep' is default, but 'astgrep' or 'astgrep-rules' can
      -- be specified
    }
  end,
}
