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

        {
          title = 'DAP REPL',
          ft = 'dap-repl',
          size = { height = 0.3 },
        },
        {
          title = 'DAP Console',
          ft = 'dapui_console',
          size = { height = 0.3 },
        },
      },
      left = {
        'neo-tree',
        {
          title = 'DAP Scopes',
          ft = 'dapui_scopes',
          size = { width = 0.25 },
        },
        {
          title = 'DAP Breakpoints',
          ft = 'dapui_breakpoints',
        },
        {
          title = 'DAP Stacks',
          ft = 'dapui_stacks',
        },
        {
          title = 'DAP Watches',
          ft = 'dapui_watches',
        },
        {
          title = 'Neo-Tree',
          ft = 'neo-tree',
          filter = function(buf)
            return vim.b[buf].neo_tree_source == 'filesystem'
          end,
          -- size = { height = 0.5 },
        },
      },
      right = {
        { ft = 'neotest-summary', title = 'Test Summary' },
      },
    },
  },
}
