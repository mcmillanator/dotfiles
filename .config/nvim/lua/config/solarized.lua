require("solarized").setup({
  theme = "solarized", -- or comment to use solarized default theme.
  options = {
    theme = require("lualine.themes.solarized"),
  },
  background = "dark",
  enables = {
    editor = true,
    syntax = true,

    -- PLUGINS
    bufferline = true,
    cmp = false, -- disabled
    diagnostic = true,
    indentblankline = true,
    lsp = true,
    lspsaga = false, -- disabled
    navic = true,
    semantic = true,
    telescope = true,
    tree = false, -- disabled
    neotree = true, -- disabled
    treesitter = true,
  },
  highlights = {
    NeoTree = true,
    -- your implementation of nvim-tree
    -- your implementation of cmp
    -- your implementation of lspsaga
  },
})
