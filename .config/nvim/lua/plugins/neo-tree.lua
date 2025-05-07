-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = function()
    local map = vim.keymap.set
    -- Define conficting keymaps
    -- Neotree
    map('n', '<leader>ge', '<cmd>Neotree git_status toggle<cr>', { desc = 'Git explorer' })
    map('n', '<leader>gf', '<cmd>Neotree git_status toggle reveal<cr>', { desc = 'Reveal in git explorer' })
    map('n', '<C-n>', '<cmd>Neotree toggle<cr>', { desc = 'Neotree toggle' })
    map('n', '<C-f>', '<cmd>Neotree reveal<cr>', { desc = 'Neotree reveal' })
    return {
      { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    }
  end,
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
