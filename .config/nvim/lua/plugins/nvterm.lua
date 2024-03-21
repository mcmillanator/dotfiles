return {
  "NvChad/nvterm",
  config = function()
    require("nvterm").setup({
      shell = vim.o.shell,
    })
  end,
}
