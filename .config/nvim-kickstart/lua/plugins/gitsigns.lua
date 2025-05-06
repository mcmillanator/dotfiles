-- Adds git related signs to the gutter, as well as utilities for managing changes
-- NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        local map = vim.keymap.set
        -- Gitsigns keymaps
        map('n', '<leader>ga', '<cmd>Gitsigns stage_hunk<cr>', { desc = 'git add' })
        map('n', '<leader>gd', '<cmd>Gitsigns diffthis<cr>', { desc = 'git dff' })
        map('n', '<leader>gu', '<cmd>Gitsigns undo_stage_hunk<cr>', { desc = 'git unstage' })
        map('n', '<leader>gsd', '<cmd>Gitsigns toggle_deleted<cr>', { desc = 'Toggle Deleted' })
        map('n', '<leader>gsw', '<cmd>Gitsigns toggle_word_diff<cr>', { desc = 'Toggle Word Diff' })
        map('n', '<leader>gsn', '<cmd>Gitsigns toggle_numhl<cr>', { desc = 'Toggle Num Hightlight' })
        map('n', '<leader>gss', '<cmd>Gitsigns toggle_signs<cr>', { desc = 'Toggle Signs' })
        map('n', '<leader>gsh', '<cmd>Gitsigns toggle_linehl<cr>', { desc = 'Toggle Line Highlight' })
        map('n', '<leader>gsb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { desc = 'Toggle Current Line Blame' })

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']g', function()
          if vim.wo.diff then
            vim.cmd.normal { ']g', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to git next change' })

        map('n', '[g', function()
          if vim.wo.diff then
            vim.cmd.normal { '[g', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to git previous change' })

        -- Actions
        -- visual mode
        map('v', '<leader>ghs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git stage hunk' })
        map('v', '<leader>ghr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git reset hunk' })
        -- normal mode
        map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>ghS', gitsigns.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>ghu', gitsigns.stage_hunk, { desc = 'git undo stage hunk' })
        map('n', '<leader>ghR', gitsigns.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>ghp', gitsigns.preview_hunk, { desc = 'git preview hunk' })
        map('n', '<leader>gb', gitsigns.blame_line, { desc = 'git blame line' })
        map('n', '<leader>ghd', gitsigns.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>ghD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git Diff against last commit' })
        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle git show blame line' })
        map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = 'Toggle git show Deleted' })
      end,
    },
  },
}
