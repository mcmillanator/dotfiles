-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
  opts = {
    -- add any options here
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    -- Configure views to reposition messages
    views = {
      notify = {
        position = {
          row = 1, -- Near the top
          col = '0%', -- Left side of the screen
        },
        size = {
          width = 'auto',
          max_width = 60,
        },
        border = {
          style = 'single',
        },
      },
    },
    -- Ensure messages and notifications use the mini or notify view
    messages = {
      enabled = true,
      view = 'notify', -- Use mini view for messages
      view_error = 'notify', -- Errors to notify
      view_warn = 'notify', -- Warnings to notify
    },
    notify = {
      enabled = true,
      view = 'notify',
    },
  },
  config = function(_, opts)
    require('noice').setup(opts)
    -- Dismiss noice all
    vim.keymap.set('n', '<leader>un', function()
      require('noice').cmd 'dismiss'
    end, { desc = 'Dismiss All' })
  end,
}
