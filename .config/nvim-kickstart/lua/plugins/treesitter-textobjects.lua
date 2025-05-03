-- Syntax aware text-objects, select, move, swap, and peek support.

-- Warning: tree-sitter and nvim-treesitter are an experimental feature of nightly versions of Neovim. Please consider the experience with this plug-in as experimental until tree-sitter support in Neovim is stable! We recommend using the nightly builds of Neovim or the latest stable version.
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  lazy = true,
  after = 'nvim-treesitter',
  config = function()
    require('nvim-treesitter.configs').setup {
      textobjects = {
        lsp_interop = {
          enable = true,
          border = 'none',
          floating_preview_opts = {},
          peek_definition_code = {
            ['<leader>df'] = '@function.outer',
            ['<leader>dF'] = '@class.outer',
          },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['=a'] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
            ['=o'] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
            ['=i'] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
            ['=l'] = { query = '@assignment.lhs', desc = 'Select left hand side of an assignment' },
            ['=r'] = { query = '@assignment.rhs', desc = 'Select right hand side of an assignment' },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
            ['@class.outer'] = '<c-v>',
          },
        },
      },
    }
  end,
}
