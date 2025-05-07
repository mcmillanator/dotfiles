return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      exclude = {
        filetypes = {
          'dashboard', -- Add this to exclude indent guides for dashboard
          -- Optionally, add other filetypes to exclude
          'help',
          'terminal',
          'lspinfo',
          'checkhealth',
          '',
        },
        buftypes = {
          'terminal',
          'nofile',
        },
      },
    },
  },
}
