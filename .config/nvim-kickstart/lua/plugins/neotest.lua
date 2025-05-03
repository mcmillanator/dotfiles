return {
  'nvim-neotest/nvim-nio',
  'nvim-lua/plenary.nvim',
  'nvim-treesitter/nvim-treesitter',
  'nvim-neotest/neotest-python',
  { 'folke/neoconf.nvim', cmd = 'Neoconf' },
  'folke/neodev.nvim',
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = true, redirectOutput = true },
        },
        require 'neotest-rspec' {
          rspec_cmd = function()
            return vim.tbl_flatten {
              'bin/rspec --fail-fast',
            }
          end,
        },
      },
      quickfix = {
        enabled = false,
        open = function()
          vim.cmd 'Trouble quickfix'
        end,
      },
    }
  end,
}
