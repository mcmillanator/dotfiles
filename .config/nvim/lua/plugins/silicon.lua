return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  config = function()
    require("silicon").setup({
      font = "Hack",
      theme = "Solarized (dark)",
      no_window_controls = true,
    })
  end,
}
