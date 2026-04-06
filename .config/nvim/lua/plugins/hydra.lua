return {
  'nvimtools/hydra.nvim',
  event = 'VeryLazy',
  config = function()
    local Hydra = require 'hydra'
    Hydra {
      name = 'Window Management',
      hint = [[
 ^ ^          Window Management
 ^ ^---------------------------------------
 _s_: split            _v_: v-split
 _h_: focus left       _j_: focus down
 _k_: focus up         _l_: focus right
 _+_: height +         _-_: height -
 _>_: width +          _<_: width -
 _=_: equalize         _q_: close
 ^ ^        _<Esc>_ or _w_: exit
]],
      config = {
        invoke_on_body = true,
        hint = {
          border = 'rounded',
          position = 'bottom',
        },
      },
      mode = 'n',
      body = '<leader>w',
      heads = {
        { 's', '<C-w>s' },
        { 'v', '<C-w>v' },
        { 'h', '<C-w>h' },
        { 'j', '<C-w>j' },
        { 'k', '<C-w>k' },
        { 'l', '<C-w>l' },
        { '+', '<C-w>+' },
        { '-', '<C-w>-' },
        { '>', '<C-w>>' },
        { '<', '<C-w><' },
        { '=', '<C-w>=' },
        { 'q', '<C-w>q' },
        { 'w', nil, { exit = true } },
        { '<Esc>', nil, { exit = true } },
      },
    }
  end,
}
