-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = true },
  config = function()
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
  end,
}
