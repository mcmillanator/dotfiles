-- Syntax aware text-objects, select, move, swap, and peek support.
--
-- The `main` branch is a rewrite: the plugin is no longer configured through
-- `nvim-treesitter.configs` opts. `setup()` only tunes `select`/`move` behavior and
-- every keymap is wired explicitly via `vim.keymap.set`. See `:help nvim-treesitter-textobjects`
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  event = 'VeryLazy',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-treesitter-textobjects').setup {
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
      },
      move = {
        -- Record jumps in the jumplist
        set_jumps = true,
      },
    }

    local select = require 'nvim-treesitter-textobjects.select'
    local move = require 'nvim-treesitter-textobjects.move'
    local shared = require 'nvim-treesitter-textobjects.shared'

    -- Select textobjects (old `select.keymaps`)
    local select_maps = {
      ['=a'] = { '@assignment.outer', 'Select outer part of an assignment' },
      ['=o'] = { '@assignment.outer', 'Select outer part of an assignment' },
      ['=i'] = { '@assignment.inner', 'Select inner part of an assignment' },
      ['=l'] = { '@assignment.lhs', 'Select left hand side of an assignment' },
      ['=r'] = { '@assignment.rhs', 'Select right hand side of an assignment' },
    }
    for lhs, map in pairs(select_maps) do
      for _, mode in ipairs { 'x', 'o' } do
        vim.keymap.set(mode, lhs, function() select.select_textobject(map[1], 'textobjects') end, { desc = map[2] })
      end
    end

    -- Jump to textobjects (old `move.goto_*` tables from the treesitter spec opts)
    local move_maps = {
      [']f'] = { 'goto_next_start', '@function.outer', 'Next function start' },
      [']c'] = { 'goto_next_start', '@class.outer', 'Next class start' },
      [']a'] = { 'goto_next_start', '@parameter.inner', 'Next parameter start' },
      [']F'] = { 'goto_next_end', '@function.outer', 'Next function end' },
      [']C'] = { 'goto_next_end', '@class.outer', 'Next class end' },
      [']A'] = { 'goto_next_end', '@parameter.inner', 'Next parameter end' },
      ['[f'] = { 'goto_previous_start', '@function.outer', 'Previous function start' },
      ['[c'] = { 'goto_previous_start', '@class.outer', 'Previous class start' },
      ['[a'] = { 'goto_previous_start', '@parameter.inner', 'Previous parameter start' },
      ['[F'] = { 'goto_previous_end', '@function.outer', 'Previous function end' },
      ['[C'] = { 'goto_previous_end', '@class.outer', 'Previous class end' },
      ['[A'] = { 'goto_previous_end', '@parameter.inner', 'Previous parameter end' },
    }
    for lhs, map in pairs(move_maps) do
      for _, mode in ipairs { 'n', 'x', 'o' } do
        vim.keymap.set(mode, lhs, function() move[map[1]](map[2], 'textobjects') end, { desc = map[3] })
      end
    end

    -- Peek definition code: the old `lsp_interop` module was dropped in the rewrite,
    -- so recreate <leader>gp/<leader>gP with the plugin's own textobject finder and a
    -- core floating preview: show the code of the function/class enclosing the cursor.
    local function peek(query_string)
      local buf = vim.api.nvim_get_current_buf()
      local range = shared.textobject_at_point(query_string, 'textobjects', buf, nil, { lookahead = true })
      if not range then return end
      -- textobject_at_point returns a Range6: {start_row, start_col, start_byte, end_row, end_col, end_byte}
      local first, last = range[1], range[4]
      if range[5] == 0 then last = last - 1 end -- end at col 0 means "up to the previous line"
      local lines = vim.api.nvim_buf_get_lines(buf, first, last + 1, false)
      if #lines == 0 then return end
      vim.lsp.util.open_floating_preview(lines, vim.bo[buf].filetype, { border = 'none', focusable = false })
    end
    vim.keymap.set('n', '<leader>gp', function() peek '@function.outer' end, { desc = 'Peek function code at cursor' })
    vim.keymap.set('n', '<leader>gP', function() peek '@class.outer' end, { desc = 'Peek class code at cursor' })
  end,
}
