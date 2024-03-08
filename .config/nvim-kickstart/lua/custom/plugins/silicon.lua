return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  config = function()
    require("silicon").setup({
      font = "Hack",
      theme = "Solarized (dark)",
      pad_horiz = 0,
      pad_vert = 0,
      no_round_corner = true,
      no_window_controls = true,
      watermark = {
        text = " @mcmillanator",
      },
    })
  end,
}
