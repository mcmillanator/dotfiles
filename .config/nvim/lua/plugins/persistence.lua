-- Persistence is a simple lua plugin for automated session management.
return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  opts = {
    -- Run some commands before saving the session
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceSavePre',
      callback = function()
        -- Close Neo-tree before saving a session
        vim.cmd 'Neotree close'
        -- Close neotest before saving a session
        require('neotest').summary.close()
      end,
      desc = 'Close Neo-tree before saving session',
    }),

    {
      dir = vim.fn.stdpath 'state' .. '/sessions/', -- directory where session files are saved
      -- minimum number of file buffers that need to be open to save
      -- Set to 0 to always save
      need = 1,
      branch = true, -- use git branch to save session
    },
  },
}
