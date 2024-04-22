-- bootstrap lazy.nvim, LazyVim and your plugins
vim.o.shell = "zsh"
require("config.lazy")
-- I have not managed to get this neotest configuration to work anywhere else
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
  },
})
