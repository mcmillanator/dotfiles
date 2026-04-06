return {
  -- Saves window sizes, positions, and open buffers.
  {
    'stevearc/resession.nvim',
    config = function()
      local resession = require 'resession'
      resession.setup {
        -- Automatically save sessions on exit
        autosave = { enabled = true },
      }

      -- Quick keys for your "Coding", "Debug", and "Testing" modes
      -- Usage: <leader>ss to save current layout, <leader>sl to switch
      vim.keymap.set('n', '<leader>S', resession.save, { desc = 'Save Workspace Layout' })
      vim.keymap.set('n', '<leader>L', resession.load, { desc = 'Load Workspace Layout' })
      vim.keymap.set('n', '<leader>D', resession.delete, { desc = 'Delete Workspace Layout' })
    end,
  },
}
