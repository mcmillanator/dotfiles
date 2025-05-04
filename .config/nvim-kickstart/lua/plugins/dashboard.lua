-- Fancy and Blazing Fast start screen plugin of neovim
return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'doom',
      week_header = {
        enable = true,
      },
      config = {
        -- header = {}, --your header
        center = {
          {
            icon = '󰊳 ',
            desc = 'Update',
            icon_hl = 'Title',
            desc_hl = 'String',
            group = '@property',
            action = 'Lazy update',
            key = 'u',

            key_format = ' %s', -- remove default surrounding `[]`
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc_hl = 'String',
            desc = 'Files',
            group = 'Label',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            icon = ' ',
            desc = 'dotfiles',
            icon_hl = 'Title',
            desc_hl = 'String',
            group = 'Number',
            key_format = ' %s', -- remove default surrounding `[]`
            action = function()
              require('telescope.builtin').live_grep { cwd = '~/Documents/Projects/dotfiles' }
            end,
            key = 'd',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Load Last Session',
            desc_hl = 'String',
            key = 'l',
            key_format = ' %s', -- remove default surrounding `[]`
            action = function()
              require('persistence').load { last = true }
            end,
          },
          {
            icon = ' ',
            desc = 'Select a session',
            icon_hl = 'Title',
            desc_hl = 'String',
            key = 's',
            key_format = ' %s', -- remove default surrounding `[]`
            action = function()
              require('persistence').select()
            end,
          },
          {
            icon = ' ',
            desc = 'Load session form pwd',
            icon_hl = 'Title',
            desc_hl = 'String',
            key = 'p',
            key_format = ' %s', -- remove default surrounding `[]`
            action = function()
              require('persistence').load()
            end,
          },
        },
        footer = {}, --your footer
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
