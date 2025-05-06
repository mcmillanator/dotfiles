-- Variables
local map = vim.keymap.set
return {

  map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Open Lazy UI' }),
  -- Define conficting keymaps
  -- Neotree
  map('n', '<leader>ge', '<cmd>Neotree git_status toggle<cr>', { desc = 'Git explorer' }),
  map('n', '<leader>gf', '<cmd>Neotree git_status toggle reveal<cr>', { desc = 'Reveal in git explorer' }),
  map('n', '<C-n>', '<cmd>Neotree toggle<cr>', { desc = 'Neotree toggle' }),
  map('n', '<C-f>', '<cmd>Neotree reveal<cr>', { desc = 'Neotree reveal' }),
  -- Gitsigns keymaps
  map('n', '<leader>ga', '<cmd>Gitsigns stage_hunk<cr>', { desc = 'git add' }),
  map('n', '<leader>gd', '<cmd>Gitsigns diffthis<cr>', { desc = 'git dff' }),
  map('n', '<leader>gu', '<cmd>Gitsigns undo_stage_hunk<cr>', { desc = 'git unstage' }),
  map('n', '<leader>gsd', '<cmd>Gitsigns toggle_deleted<cr>', { desc = 'Toggle Deleted' }),
  map('n', '<leader>gsw', '<cmd>Gitsigns toggle_word_diff<cr>', { desc = 'Toggle Word Diff' }),
  map('n', '<leader>gsn', '<cmd>Gitsigns toggle_numhl<cr>', { desc = 'Toggle Num Hightlight' }),
  map('n', '<leader>gss', '<cmd>Gitsigns toggle_signs<cr>', { desc = 'Toggle Signs' }),
  map('n', '<leader>gsh', '<cmd>Gitsigns toggle_linehl<cr>', { desc = 'Toggle Line Highlight' }),
  map('n', '<leader>gsb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { desc = 'Toggle Current Line Blame' }),

  -- Diagnostic keymaps
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous Diagnostic message' }),
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next Diagnostic message' }),
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic Error messages' }),
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic Quickfix list' }),

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }),

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' }),
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' }),
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' }),
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' }),
}
