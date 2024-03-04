local wk = require("which-key")
return {
  wk.register({
    name = "Telescope",
    mode = "n",
    prefix = "<leader>t",
  }),
  wk.register({
    name = "Gitsigns",
    mode = "n",
    prefix = "<leader>gs",
  }),
}
