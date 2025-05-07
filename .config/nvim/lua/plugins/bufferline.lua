-- A snazzy 💅 buffer line (with tabpage integration) for Neovim built using lua.
vim.opt.termguicolors = true
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function(_, opts)
    -- Setup bufferline with provided options
    require('bufferline').setup(opts)

    -- Custom function to toggle bufferline visibility
    local function toggle_bufferline()
      if vim.opt.showtabline:get() == 2 then
        vim.opt.showtabline = 0 -- Hide bufferline
      else
        vim.opt.showtabline = 2 -- Show bufferline
      end
    end

    -- Keymaps
    local map = vim.keymap.set
    -- Navigation
    map('n', ']b', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })
    map('n', '[b', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Prev Buffer' })
    map('n', ']B', '<Cmd>BufferLineMoveNext<CR>', { desc = 'Move buffer next' })
    map('n', '[B', '<Cmd>BufferLineMovePrev<CR>', { desc = 'Move buffer prev' })

    -- <leader>b prefixed keymaps
    map('n', '<leader>b]', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })
    map('n', '<leader>b[', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Prev Buffer' })
    map('n', '<leader>bt', toggle_bufferline, { desc = 'Toggle bufferline visibility' })
    map('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', { desc = 'Toggle buffer pin' })
    map('n', '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', { desc = 'Delete non-pinned buffers' })
    map('n', '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', { desc = 'Delete buffers to the left' })
    map('n', '<leader>br', '<Cmd>BufferLineCloseRight<CR>', { desc = 'Delete buffers to the right' })
  end,
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      always_show_bufferline = true, -- Changed to true to always show bufferline
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
        {
          filetype = 'snacks_layout_box',
        },
      },
    },
  },
}
