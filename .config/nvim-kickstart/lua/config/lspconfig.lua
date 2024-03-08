require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {},
  automatic_installation = false,
  handlers = nil,
})
lspconfig = require("lspconfig")
lspconfig.pylsp.setup({
  --on_attach = custom_attach,
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        black = { enabled = false },
        mccabe = { enabled = false, threshold = 15 },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = false },
        pyflakes = { enabled = false },
        flake8 = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = true },
      },
    },
  },
  flags = {
    debounce_text_changes = 200,
  },
  capabilities = capabilities,
})
