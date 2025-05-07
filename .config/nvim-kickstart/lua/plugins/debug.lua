-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
    -- TODO: find out if I still need to declare these manually
    'mfussenegger/nvim-dap-python',
    -- "suketa/nvim-dap-ruby",
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<leader>dsi',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<leader>dsv',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<leader>dso',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>B',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>dd',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<leader>dt',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
    {
      '<leader>dbt',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Toggle Debug Breakpoint',
    },
    {
      '<leader>dbq',
      function()
        require('dap').list_breakpoints()
      end,
      desc = 'Quickfix all breakpoints',
    },
    {
      '<leader>dbc',
      function()
        require('dap').clear_breakpoints()
      end,
      desc = 'Clear all breakpoints',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('dap-python').setup 'python3'
    -- Python DAP configurations
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Pytest',
        module = 'pytest',
        pythonPath = function()
          return 'python3'
        end,
        console = 'integratedTerminal',
      },
      {
        type = 'python',
        request = 'launch',
        name = 'Python file',
        program = '${file}', -- Debug the current file
        pythonPath = function()
          return 'python3'
        end,
        console = 'integratedTerminal',
      },
      {
        type = 'python',
        request = 'launch',
        name = 'Pytest file',
        module = 'pytest',
        args = { '${file}', '-v' }, -- Debug the current test file
        pythonPath = function()
          return 'python3'
        end,
        console = 'integratedTerminal',
      },

      {
        type = 'python',
        request = 'launch',
        name = 'Debug single pytest',
        module = 'pytest',
        args = function()
          local file = vim.fn.expand '%:p' -- Full path to current file
          local test_name = ''

          -- Search backward for a test function or method
          local line = vim.fn.search('^def test_w+', 'bcnW')
          if line > 0 then
            local line_text = vim.fn.getline(line)
            test_name = line_text:match 'def (test_%w+)'
          else
            -- Check for class-based test (e.g., class TestMyClass)
            local class_line = vim.fn.search('^class Testw+', 'bcnW')
            if class_line > 0 then
              local class_text = vim.fn.getline(class_line)
              local class_name = class_text:match 'class (Test%w+)'
              -- Search forward from class for a test method
              local method_line = vim.fn.search('^    def test_w+', 'cnW', vim.fn.line '$')
              if method_line > 0 then
                local method_text = vim.fn.getline(method_line)
                local method_name = method_text:match 'def (test_%w+)'
                if method_name then
                  test_name = class_name .. '::' .. method_name
                end
              end
            end
          end

          -- Fallback to user input if no test is found
          if test_name == '' or test_name == nil then
            test_name = vim.fn.input 'Test name (e.g., test_function or TestClass::test_method): '
          end

          -- If still empty, run all tests in file
          if test_name == '' then
            return { file, '-v' }
          end
          return { file .. '::' .. test_name, '-v' }
        end,
        pythonPath = function()
          return 'python' -- Or '/path/to/your/poetry/env/bin/python'
        end,
        console = 'integratedTerminal',
      },
    }
    require('mason').setup()
    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'debugpy',
        'flake8',
        'shellcheck',
        'shfmt',
        'stylua',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
    -- Add a listener to log when the debugger stops
    dap.listeners.after.event_stopped['dapui_config'] = function()
      print 'Debugger stopped'
      dapui.open()
    end
    dap.set_log_level 'TRACE'

    -- Install golang specific config
    -- require('dap-go').setup {
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }
  end,
}
