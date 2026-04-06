return {
  -- Highly recommended for LazyVim users to "fix" window positions
  -- so that sidebars (Neo-tree, Debugger) don't jump around.
  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    opts = {
      bottom = {
        { ft = 'toggleterm', title = 'Terminal', size = { height = 0.4 } },
        { ft = 'qf', title = 'Quickfix' },
      },
      left = {
        'neo-tree',
        {
          title = 'Neo-Tree',
          ft = 'neo-tree',
          filter = function(buf)
            return vim.b[buf].neo_tree_source == 'filesystem'
          end,
          size = { height = 0.5 },
        },
      },
      right = {
        { ft = 'neotest-summary', title = 'Test Summary' },
      },
    },
  },
}
