-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = true },
  config = function()
    require('todo-comments').setup()
    vim.keymap.set('n', ']t', function()
      require('todo-comments').jump_next()
    end, { desc = 'Next todo comment' })

    vim.keymap.set('n', '[t', function()
      require('todo-comments').jump_prev()
    end, { desc = 'Previous todo comment' })

    -- You can also specify a list of valid jump keywords

    vim.keymap.set('n', ']e', function()
      require('todo-comments').jump_next { keywords = { 'ERROR', 'WARNING' } }
    end, { desc = 'Next error/warning todo comment' })
    vim.keymap.set('n', '[e', function()
      require('todo-comments').jump_prev { keywords = { 'ERROR', 'WARNING' } }
    end, { desc = 'Next error/warning todo comment' })
    -- telescope
    vim.keymap.set('n', '<leader>stn', '<cmd>TodoTelescope keywords=NOTE<cr>', { desc = 'Search NOTE' })
    vim.keymap.set('n', '<leader>stt', '<cmd>TodoTelescope keywords=TODO<cr>', { desc = 'Search TODO' })
    vim.keymap.set('n', '<leader>stt', '<cmd>TodoTelescope keywords=TODO<cr>', { desc = 'Search FIX' })
    vim.keymap.set('n', '<leader>sta', '<cmd>TodoTelescope<cr>', { desc = 'Search all todos' })
  end,
}
