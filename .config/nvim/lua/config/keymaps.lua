-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
vim.keymap.del("n", "<leader>gs")
map("n", "<leader>tn", "<cmd>Telescope notify<cr>", { desc = "notify" })
map("n", "<leader>gst", "<cmd>Telescope git_status<cr>", { desc = "git status" })
map("n", "<leader>gS", "<cmd>Telescope git_status<cr>", { desc = "git status" })
map("n", "<leader>ga", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
map("n", "<leader>gsd", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "Toggle Deleted" })
map("n", "<leader>gsw", "<cmd>Gitsigns toggle_word_diff<cr>", { desc = "Toggle Word Diff" })
map("n", "<leader>gsn", "<cmd>Gitsigns toggle_numhl<cr>", { desc = "Toggle Num Hightlight" })
map("n", "<leader>gss", "<cmd>Gitsigns toggle_signs<cr>", { desc = "Toggle Signs" })
map("n", "<leader>gsh", "<cmd>Gitsigns toggle_linehl<cr>", { desc = "Toggle Line Highlight" })
map("n", "<leader>gsb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Current Line Blame" })
