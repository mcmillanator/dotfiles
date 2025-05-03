return {
  --{ 'folke/neoconf.nvim', cmd = 'Neoconf' },
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'nvim-neotest/neotest-plenary',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
    'olimorris/neotest-rspec',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = true, redirectOutput = true, showReturnValue = true },
        },
        require 'neotest-plenary',
        require 'neotest-rspec' {
          rspec_cmd = function()
            return vim.tbl_flatten {
              'bin/rspec --fail-fast',
            }
          end,
        },
      },
    }
  end,
}
