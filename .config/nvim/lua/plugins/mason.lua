return {
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "flake8",
        "shellcheck",
        "shfmt",
        "stylua",
      },
    },
  },
}
