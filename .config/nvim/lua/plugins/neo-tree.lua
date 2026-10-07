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
  -- NOTE: `keys` must be a pure spec table (no side effects). lazy.nvim
  -- registers these for lazy-loading; imperative maps belong in `config`.
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>ge', '<cmd>Neotree git_status toggle<cr>', desc = 'Git explorer' },
    { '<leader>gf', '<cmd>Neotree git_status toggle reveal<cr>', desc = 'Reveal in git explorer' },
    { '<C-n>', '<cmd>Neotree toggle<cr>', desc = 'Neotree toggle' },
    { '<C-f>', '<cmd>Neotree reveal<cr>', desc = 'Neotree reveal' },
  },
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
