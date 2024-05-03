return {
  "michaelrommel/nvim-silicon",
  lazy = false,
  cmd = "Silicon",
  config = function()
    require("silicon").setup({
      font = "Hack Nerd Font",
      theme = "Solarized (dark)",
      pad_horiz = 0,
      pad_vert = 0,
      no_round_corner = true,
      no_window_controls = true,
    })
  end,
}
