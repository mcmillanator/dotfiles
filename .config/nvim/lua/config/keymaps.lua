-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Variables
local map = vim.keymap.set
local term = require("nvterm.terminal")
local term_modes = { "n", "v", "i", "t" }
local dap = require("dap")
local dapui = require("dapui")
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
map("n", "<leader>tn", "<cmd>Telescope notify<cr>", { desc = "[T]elescope [n]otify" })
map("n", "<leader>tk", "<cmd>Telescope keymaps<cr>", { desc = "[T]elescope [k]eymaps" })
map("n", "<leader>gst", "<cmd>Telescope git_status<cr>", { desc = "[g]it [s]tatus" })
map("n", "<leader>gS", "<cmd>Telescope git_status<cr>", { desc = "[g]it [s]tatus" })
map("n", "<leader>fp", function()
  require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
end, { desc = "[F]ind [P]lugin File" })
map("n", "<leader>fa", function()
  require("telescope.builtin").find_files({ hidden = true, no_ignore = true, use_git_root = true })
end, { desc = "[F]ind [A]ll Files (git root)" })
-- Gitsigns keymaps
map("n", "<leader>ga", "<cmd>Gitsigns stage_hunk<cr>", { desc = "[g]it [a]dd" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "[g]it [d]ff" })
map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "[g]it [u]nstage" })
map("n", "<leader>gsd", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "Toggle [D]eleted" })
map("n", "<leader>gsw", "<cmd>Gitsigns toggle_word_diff<cr>", { desc = "Toggle [W]ord Diff" })
map("n", "<leader>gsn", "<cmd>Gitsigns toggle_numhl<cr>", { desc = "Toggle [N]um Hightlight" })
map("n", "<leader>gss", "<cmd>Gitsigns toggle_signs<cr>", { desc = "Toggle [S]igns" })
map("n", "<leader>gsh", "<cmd>Gitsigns toggle_linehl<cr>", { desc = "Toggle Line [H]ighlight" })
map("n", "<leader>gsb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Current Line [B]lame" })
-- nvterm keymaps
map("n", "<leader>tf", term_float, { noremap = true, silent = true, desc = "[T]erminal [F]loating" })
map("n", "<leader>th", term_horizontal, { noremap = true, silent = true, desc = "[T]erminal [H]orizontal" })
map("n", "<leader>tv", term_vertical, { noremap = true, silent = true, desc = "[T]erminal [V]ertical" })
map(term_modes, "<A-f>", term_float, { noremap = true, silent = true, desc = "Floating terminal" })
map(term_modes, "<A-h>", term_horizontal, { noremap = true, silent = true, desc = "Horizontal terminal" })
map(term_modes, "<A-v>", term_vertical, { noremap = true, silent = true, desc = "Vertical terminal" })
-- nvim-dap
map("n", "<Leader>dt", function()
  dap.toggle_breakpoint()
end, { desc = "Toggle Debug [B]reakpoint" })

map("n", "<Leader>dc", function()
  dap.continue()
end, { desc = "Debug [C]ontinue" })

map("n", "<Leader>dbq", function()
  dap.list_breakpoints()
end, { desc = "[Q]uickfix all breakpoints" })

map("n", "<Leader>dbc", function()
  dap.clear_breakpoints()
end, { desc = "[C]lear all breakpoints" })

map("n", "<Leader>di", function()
  dap.set_into()
end, { desc = "Step [i]nto" })

map("n", "<Leader>do", function()
  dap.set_over()
end, { desc = "Set [o]ver" })
