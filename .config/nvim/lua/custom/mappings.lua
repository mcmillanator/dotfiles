---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    }

  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!
M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>fc"] = { "<cmd> Telescope commands <CR>", "Find command" },
    ["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "List normal mode keymappings" },

    -- git
    ["<leader>gm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gbr"] = { "<cmd> Telescope git_branches <CR>", "Git branches" },
    ["<leader>gbl"] = { "<cmd> Telescope git_commits <CR>", "Git blame" },
    ["<leader>gst"] = { "<cmd> Telescope git_status <CR>", "Git status" },
    ["<leader>gsa"] = { "<cmd> Telescope git_stash <CR>", "Git stash" },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    ["<leader>ga"] = { "<cmd> Gitsigns stage_hunk <CR>", "Git add hunk"},
    ["<leader>gu"] = { "<cmd> Gitsigns undo_stage_hunk <CR>", "Git undo add hunk"},
    ["<leader>gr"] = { "<cmd> Gitsigns reset_hunk <CR>", "Git reset hunk"},
    ["<leader>gp"] = { "<cmd> Gitsigns preview_hunk <CR>", "Git preview hunk"},
    ["<leader>gd"] = { "<cmd> Gitsigns diffthis <CR>", "Git diff"},
  }
}
return M
