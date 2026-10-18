-- OpenCode chat frontend (:help opencode.nvim; docs/servers.md upstream).
-- Connects to the qvac container stack's opencode serve on the host
-- (basic auth opencode:admin). Docs: the port goes in `server.port`, NOT in
-- `url`. If the serve is not listening the plugin spawns a local one — so
-- start the container first. auto_kill stays default (true) to reap those.
return {
  'sudo-tee/opencode.nvim',
  dependencies = {
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        anti_conceal = { enabled = false },
        file_types = { 'markdown', 'opencode_output' },
      },
      ft = { 'markdown', 'opencode_output' },
    },
  },
  opts = {
    server = {
      -- scheme://host only; $OPENCODE_SERVER_URL must not include a port.
      url = vim.env.OPENCODE_SERVER_URL or 'http://127.0.0.1',
      port = tonumber(vim.env.OPENCODE_SERVER_PORT) or 8082,
      username = 'opencode',
      -- function form: honors $OPENCODE_PASSWORD set after startup, falls
      -- back to the qvac stack's default credential.
      password = function()
        return vim.env.OPENCODE_PASSWORD or 'admin'
      end,
    },
  },
}
