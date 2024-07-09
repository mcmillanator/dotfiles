return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add tsx and treesitter
    vim.list_extend(opts.ensure_installed, {
      "bash",
      "graphql",
      "html",
      "http",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "ruby",
      "tsx",
      "typescript",
      "vim",
      "xml",
      "yaml",
    })
  end,
}
