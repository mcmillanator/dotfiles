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
    ["<leader>ff"] = { "<cmd> Telescope git_files <CR>", "Find files" },
    ["<leader>fc"] = { "<cmd> Telescope commands <CR>", "Find command" },
    ["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "List normal mode keymappings" },

    -- git
    ["<leader>gm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gbr"] = { "<cmd> Telescope git_branches <CR>", "Git branches" },
    ["<leader>gbl"] = { "<cmd> Telescope git_blame <CR>", "Git blame" },
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
    ["<leader>gtw"] = { "<cmd> Gitsigns toggle_word_diff <CR>", "Git toggle word diff"},
    ["<leader>gtl"] = { "<cmd> Gitsigns toggle_linehl <CR>", "Git toggle line highlight"},
    ["<leader>gtn"] = { "<cmd> Gitsigns toggle_numhl <CR>", "Git toggle num hightlight"},
    ["<leader>gts"] = { "<cmd> Gitsigns toggle_signs <CR>", "Git toggle signs"},
    ["<leader>gtd"] = { "<cmd> Gitsigns toggle_deleted <CR>", "Git toggle deleted"},
    ["<leader>gtc"] = { "<cmd> Gitsigns toggle_current_line_blame <CR>", "Git toggle current line blame"},
  }
}

M.tabs = {
  n = {
    ["<leader>to"] = { "<cmd> tabnew <CR>", "Tab new"},
    ["<leader>tn"] = { "<cmd> tabn <CR>", "Tab next"},
    ["<leader>tp"] = { "<cmd> tabp <CR>", "Tab previous"},
  },
}

M.obsession = {

  n = {
    ["<leader>obs"] = { "<cmd> Obsess <CR>", "Obsession save / pause"},
    ["<leader>obl"] = { "<cmd> source Session.vim <CR>", "Obsession load"},
  }
}

return M
