return {
  'MagicDuck/grug-far.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Optional for icons
  -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
  -- additional lazy config to defer loading is not really needed...
  keys = {
    -- NOTE: `<leader>gf` belongs to neo-tree (`Reveal in git explorer`);
    -- grug-far lives under Search as `<leader>sR` instead.
    { '<leader>sR', '<cmd>GrugFar<cr>', desc = 'Search & Replace (grug-far)' },
  },
  config = function()
    -- optional setup call to override plugin options
    -- alternatively you can set options with vim.g.grug_far = { ... }
    require('grug-far').setup {
      -- options, see Configuration section below
      -- there are no required options atm
      -- engine = 'ripgrep' is default, but 'astgrep' or 'astgrep-rules' can
      -- be specified
    }
  end,
}
