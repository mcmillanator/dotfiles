-- A code outline window for skimming and quick navigation
-- https://github.com/stevearc/aerial.nvim

return {
  'stevearc/aerial.nvim',
  lazy = false,
  opts = {},
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('aerial').setup {
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '<leader>a[', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '<leader>a]', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
      filter_kind = false,
      manage_folds = true,
      link_folds_to_tree = false,
      link_tree_to_folds = true,
      show_guides = true,
      autojump = true,
    }
    vim.keymap.set('n', '<leader>at', '<cmd>AerialToggle!<CR>')
  end,
}
