-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Variables
local map = vim.keymap.set
local term = require("nvterm.terminal")
--TODO: move to dap config file
local dap = require("dap")
-- TODO: move to dapui config file
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
wk.add({
  { "<leader>c", group = "Code" },
  { "<leader>g", group = "Git" },
  { "<leader>s", group = "Search" },
  {
    "<leader>b",
    group = "buffers",
    expand = function()
      return require("which-key.extras").expand.buf()
    end,
  },
})
wk.add({
  { "<leader>t", group = "Telescope/Terminal" },
  { "<leader>gs", group = "Gitsigns" },
  { "<leader>d", group = "Debugger" },
})

map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy UI" })
-- Define conficting keymaps
-- Neotree
map("n", "<leader>n", "<cmd>Neotree toggle<cr>", { desc = "Neotree toggle" })
map("n", "<leader>ge", "<cmd>Neotree git_status toggle<cr>", { desc = "Git explorer" })
map("n", "<leader>gf", "<cmd>Neotree git_status toggle reveal<cr>", { desc = "Reveal in git explorer" })
map("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "Neotree toggle" })
map("n", "<C-f>", "<cmd>Neotree reveal<cr>", { desc = "Neotree reveal" })
-- Telescope keymaps
map("n", "<leader>tn", "<cmd>Telescope noice<cr>", { desc = "Show notifications in Telescope" })
map("n", "<leader>tk", "<cmd>Telescope keymaps<cr>", { desc = "Telescope keymaps" })
map("n", "<leader>tk", "<cmd>Telescope keymaps<cr>", { desc = "Telescope keymaps" })
map("n", "<leader>gst", "<cmd>Telescope git_status<cr>", { desc = "git status" })
map("n", "<leader>gS", "<cmd>Telescope git_status<cr>", { desc = "git status" })
-- Search
map("n", "<leader>sc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Commands" })
-- Find
local telescope = require("telescope.builtin")

map("n", "<leader>fp", function()
  telescope.find_files({ cwd = require("lazy.core.config").options.root })
end, { desc = "Find Plugin File" })

map("n", "<leader>fa", function()
  telescope.find_files({ hidden = true, no_ignore = true, use_git_root = true })
end, { desc = "Find All Files (git root)" })

map("n", "<leader>ff", function()
  telescope.find_files({ hidden = true, use_git_root = true })
end, { desc = "Find Files (git root)" })

map("n", "<C-p>", function()
  telescope.find_files({ hidden = true, use_git_root = true })
end, { desc = "Find Files (git root)" })

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
-- TODO: Move to dap config file
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
end, { desc = "Step over" })

map("n", "<Leader>dut", function()
  dapui.toggle()
end, { desc = "Toggle dapui" })

map("n", "<Leader>duo", function()
  dapui.open()
end, { desc = "Open dapui" })

map("n", "<Leader>duc", function()
  dapui.close()
end, { desc = "Close dapui" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous Diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next Diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- vim: ts=2 sts=2 sw=2 et
