return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = true,
  after = "nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["=a"] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            ["=o"] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            ["=i"] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
            ["=l"] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
            ["=r"] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
          },
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"] = "V",
            ["@class.outer"] = "<c-v>",
          },
        },
      },
    })
  end,
}
