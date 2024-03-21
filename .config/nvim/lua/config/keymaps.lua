-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Variables
local map = vim.keymap.set
local term = require("nvterm.terminal")
local term_modes = { "n", "v", "i", "t" }
local dap = require("dap")
local term_float = function()
  term.toggle("float")
end
local term_vertical = function()
  term.toggle("vertical")
end
local term_horizontal = function()
  term.toggle("horizontal")
end

-- Which key prefix registration
local wk = require("which-key")
wk.register({
  name = "Telescope/Terminal",
  mode = "n",
  prefix = "<leader>t",
})
wk.register({
  name = "Gitsigns",
  mode = "n",
  prefix = "<leader>gs",
})
wk.register({
  name = "Debugger",
  mode = "n",
  prefix = "<leader>d",
})

-- Define conficting keymaps
vim.keymap.del("n", "<leader>gs")
vim.keymap.del("n", "<leader>ff")
-- Telescope keymaps
map("n", "<leader>tn", "<cmd>Telescope notify<cr>", { desc = "Telescope notify" })
map("n", "<leader>tk", "<cmd>Telescope keymaps<cr>", { desc = "Telescope keymaps" })
map("n", "<leader>gst", "<cmd>Telescope git_status<cr>", { desc = "git status" })
map("n", "<leader>gS", "<cmd>Telescope git_status<cr>", { desc = "git status" })
map("n", "<leader>fp", function()
  require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
end, { desc = "Find Plugin File" })
map("n", "<leader>fa", function()
  require("telescope.builtin").find_files({ hidden = true, no_ignore = true, use_git_root = true })
end, { desc = "Find All Files (git root)" })
-- Gitsigns keymaps
map("n", "<leader>ga", "<cmd>Gitsigns stage_hunk<cr>", { desc = "git add" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "git dff" })
map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "git unstage" })
map("n", "<leader>gsd", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "Toggle Deleted" })
map("n", "<leader>gsw", "<cmd>Gitsigns toggle_word_diff<cr>", { desc = "Toggle Word Diff" })
map("n", "<leader>gsn", "<cmd>Gitsigns toggle_numhl<cr>", { desc = "Toggle Num Hightlight" })
map("n", "<leader>gss", "<cmd>Gitsigns toggle_signs<cr>", { desc = "Toggle Signs" })
map("n", "<leader>gsh", "<cmd>Gitsigns toggle_linehl<cr>", { desc = "Toggle Line Highlight" })
map("n", "<leader>gsb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Current Line Blame" })
-- nvterm keymaps
map("n", "<leader>tf", term_float, { noremap = true, silent = true, desc = "Terminal Floating" })
map("n", "<leader>th", term_horizontal, { noremap = true, silent = true, desc = "Terminal Horizontal" })
map("n", "<leader>tv", term_vertical, { noremap = true, silent = true, desc = "Terminal Vertical" })
map(term_modes, "<A-f>", term_float, { noremap = true, silent = true, desc = "Floating terminal" })
map(term_modes, "<A-h>", term_horizontal, { noremap = true, silent = true, desc = "Horizontal terminal" })
map(term_modes, "<A-v>", term_vertical, { noremap = true, silent = true, desc = "Vertical terminal" })
-- nvim-dap
map("n", "<Leader>dt", function()
  dap.toggle_breakpoint()
end, { desc = "Toggle Debug Breakpoint" })

map("n", "<Leader>dc", function()
  dap.continue()
end, { desc = "Debug Continue" })

map("n", "<Leader>dbq", function()
  dap.list_breakpoints()
end, { desc = "Quickfix all breakpoints" })

map("n", "<Leader>dbc", function()
  dap.clear_breakpoints()
end, { desc = "Clear all breakpoints" })

map("n", "<Leader>di", function()
  dap.set_into()
end, { desc = "Step into" })

map("n", "<Leader>do", function()
  dap.set_over()
end, { desc = "Set over" })
