return {
  -- Saves window sizes, positions, and open buffers.
  {
    'stevearc/resession.nvim',
    -- NOTE: persistence.nvim owns *automatic* session save/restore.
    -- resession is for *manual* named workspace layouts only, so its
    -- autosave stays off -- otherwise both plugins write on exit and
    -- whichever restores last wins.
    opts = {
      autosave = { enabled = false },
    },
    keys = {
      { '<leader>S', function() require('resession').save() end, desc = 'Save Workspace Layout (resession)' },
      { '<leader>L', function() require('resession').load() end, desc = 'Load Workspace Layout (resession)' },
      { '<leader>D', function() require('resession').delete() end, desc = 'Delete Workspace Layout (resession)' },
    },
  },
}
