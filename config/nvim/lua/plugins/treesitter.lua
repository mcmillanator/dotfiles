return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  -- The `master` branch (v0.10.x) is frozen and does not work on nvim 0.12+.
  -- The `main` branch is an incompatible rewrite: there is no `nvim-treesitter.configs`
  -- opts table anymore, and highlight/fold are enabled via core nvim APIs. See `:help nvim-treesitter`
  branch = 'main',
  lazy = false, -- the rewritten plugin does not support lazy-loading
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'

    -- [[ Parser installation ]]
    -- Replaces the old `ensure_installed` option. `install()` is a no-op for parsers
    -- that are already up-to-date and downloads/builds the rest asynchronously.
    -- Failures (if any) are reported by `:TSLog` and `:checkhealth nvim-treesitter`.
    ts.install {
      'bash',
      'c',
      'diff',
      'graphql',
      'html',
      'http',
      'javascript',
      'json',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'ruby',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
    }

    -- Languages where vim's regex highlighting should stay enabled alongside treesitter
    -- (replaces the old `highlight.additional_vim_regex_highlighting`)
    local keep_vim_regex = { ruby = true }
    -- Languages for which treesitter indentation proved unreliable (replaces the old `indent.disable`)
    local skip_ts_indent = { ruby = true }

    ---@param buf integer
    ---@param language string
    local function treesitter_try_attach(buf, language)
      -- The buffer might be gone by the time an async install finishes
      if not vim.api.nvim_buf_is_valid(buf) then return end
      -- Check a parser is actually loadable before enabling treesitter features for it
      if not vim.treesitter.language.add(language) then return end

      -- Highlighting, provided by core nvim (`:help treesitter-highlight`)
      vim.treesitter.start(buf, language)
      if keep_vim_regex[language] then
        vim.bo[buf].syntax = 'ON'
      end

      -- Folds, provided by core nvim
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'

      -- Indentation, provided by nvim-treesitter (`:help nvim-treesitter-indentation`),
      -- but only for languages that ship an indents query and aren't known-broken
      if not skip_ts_indent[language] and vim.treesitter.query.get(language, 'indents') ~= nil then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    local available_parsers = ts.get_available()
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Enable treesitter highlighting, folds and indentation for supported filetypes',
      callback = function(args)
        local buf, filetype = args.buf, args.match

        local language = vim.treesitter.language.get_lang(filetype)
        if not language then return end

        if vim.tbl_contains(ts.get_installed 'parsers', language) then
          treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
          -- Replaces the old `auto_install = true`: fetch the parser on demand and attach once done
          ts.install(language):await(function() treesitter_try_attach(buf, language) end)
        else
          -- The parser may still exist from another source (e.g. bundled by a plugin)
          treesitter_try_attach(buf, language)
        end
      end,
    })

    -- [[ Incremental selection ]]
    -- The old `incremental_selection` module is gone; nvim 0.12 ships native incremental
    -- selection (`:help treesitter-incremental-selection`: `an`/`in`/`[n`/`]n`/`[N`/`]N` in
    -- visual mode). Keep the old module's default keys, now backed by `vim.treesitter.select()`.
    local function ts_select(target)
      return function()
        -- `vim.b.ts_highlight` is set by core once treesitter highlighting runs in the buffer
        if vim.b.ts_highlight then vim.treesitter.select(target) end
      end
    end
    vim.keymap.set('n', 'gnn', ts_select 'parent', { desc = 'Treesitter: start selection at parent node' })
    vim.keymap.set('x', 'grn', ts_select 'parent', { desc = 'Treesitter: expand selection to parent node' })
    vim.keymap.set('x', 'grm', ts_select 'child', { desc = 'Treesitter: shrink selection to child node' })

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with treesitter. You should go explore a few and see what interests you:
    --
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}
