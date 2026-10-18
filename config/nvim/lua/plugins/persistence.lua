-- Persistence is a simple lua plugin for automated session management.
return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  opts = {
    dir = vim.fn.stdpath 'state' .. '/sessions/', -- directory where session files are saved
    -- minimum number of file buffers that need to be open to save
    -- Set to 0 to always save
    need = 1,
    branch = true, -- use git branch to save session
  },
  config = function(_, opts)
    require('persistence').setup(opts)
    -- Run some commands before saving the session.
    -- NOTE: this autocmd must live in `config`, not inside `opts`
    -- (lazy.nvim forwards `opts` to `setup()`, which would ignore it).
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceSavePre',
      callback = function()
        -- pcall: Neo-tree/neotest may not be loaded when this fires
        pcall(function()
          vim.cmd 'Neotree close'
        end)
        pcall(function()
          require('neotest').summary.close()
          require('neotest').output_panel.close()
          require('aerial').close()
        end)
      end,
      desc = 'Close Neo-tree before saving session',
    })
  end,
}
