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
    local neotest = require 'neotest'
    local map = vim.keymap.set

    map('n', '<leader>df', function()
      neotest.run.run { vim.fn.expand '%', strategy = 'dap' }
    end, { desc = 'Debug File' })

    map('n', '<leader>dn', function()
      neotest.run.run { strategy = 'dap' }
    end, { desc = 'Debug Nearest' })

    map('n', '<leader>no', function()
      neotest.output_panel.toggle()
    end, { desc = 'Neotest Output Panel' })

    map('n', '<leader>nr', function()
      neotest.run.run(vim.fn.expand '%')
    end, { desc = 'Neotest Run' })

    map('n', '<leader>nn', function()
      neotest.run.run()
    end, { desc = 'Neotest Run Nearest' })

    map('n', '<leader>n]', function()
      neotest.jump.next { status = 'failed ' }
    end, { desc = 'Next failed test' })

    map('n', '<leader>n[', function()
      neotest.jump.prev { status = 'failed ' }
    end, { desc = 'Prev failed test' })

    map('n', '<leader>nl', function()
      neotest.run.run_last()
    end, { desc = 'Neotest Run Last' })

    map('n', '<leader>dl', function()
      neotest.run.run_last { strategy = 'dap' }
    end, { desc = 'Debug Last' })

    map('n', '<leader>nS', function()
      neotest.run.stop()
    end, { desc = 'Neotest Stop' })

    map('n', '<leader>ns', function()
      neotest.run.status()
    end, { desc = 'Neotest status' })

    map('n', '<leader>nt', function()
      neotest.summary.toggle()
    end, { desc = 'Neotest Summary Toggle' })

    map('n', '<leader>nwn', function()
      neotest.watch.toggle()
    end, { desc = 'Neotest Watch Nearest' })

    map('n', '<leader>nwf', function()
      neotest.watch.toggle(vim.fn.expand '%')
    end, { desc = 'Neotest Watch File' })

    map('n', '<leader>nws', function()
      neotest.watch.stop()
    end, { desc = 'Neotest Watch Stop' })

    neotest.setup {
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
