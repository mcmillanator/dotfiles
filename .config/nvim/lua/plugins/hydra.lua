return {
  {
    'nvimtools/hydra.nvim',
    event = 'VeryLazy', -- Loads only when needed to keep startup fast
    config = function()
      local Hydra = require 'hydra'

      Hydra {
        name = 'Window Management',
        mode = 'n',
        body = '<C-w>',
        config = {
          -- 1000ms is the community favorite for a "sticky" mode
          timeout = 1000,
          invoke_on_body = true,
          hint = false,
        },
        heads = {
          -- Navigation
          { 'h', '<C-w>h' },
          { 'j', '<C-w>j' },
          { 'k', '<C-w>k' },
          { 'l', '<C-w>l' },
          -- Resizing (repeated taps feel very smooth here)
          { '+', '2<C-w>+' },
          { '-', '2<C-w>-' },
          { '>', '5<C-w>>' },
          { '<', '5<C-w><' },
          -- Splits
          { 's', '<C-w>s' },
          { 'v', '<C-w>v' },
          -- Exit
          { 'q', '<C-w>q' },
          { '<Esc>', nil, { exit = true } },
        },
      }
    end,
  },
}
