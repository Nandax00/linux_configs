require("lualine").setup {
  sections = {
    lualine_b = { "diagnostics" },
    lualine_c = {
      {
        "filename",
        newfile_status = true,
        path = 1,
        symbols = { modified = "●" },
      }
    },
  },
  tabline = {
    lualine_a = {
      {
        "tabs",
        tab_max_length = 20,
        max_length = vim.o.columns - 40,
        mode = 2,
        use_mode_colors = true,
        symbols = { modified = " ●" },
      }
    },
    lualine_b = {
      {
        "branch",
        max_length = 30,
      },
      "diff",
    },
  },
}

require("nvim-treesitter.configs").setup {
  ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local disabled_fts = { "gitrebase" }
      if disabled_fts[lang] then
        return true
      end
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
}

require("telescope").setup {
  defaults = {
    layout_strategy = "vertical",
    sorting_strategy = "descending",
    wrap_results = true,
    file_ignore_patterns = {
      ".mak",
      ".svg",
      "Makefile",
    },
  },
}

require("mason").setup {}

local lsp = require("lspconfig")
lsp.clangd.setup {
  cmd = {
    "clangd",
    "--offset-encoding=utf-16"
  },
}
lsp.jsonls.setup {}
lsp.marksman.setup {}
lsp.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
}
lsp.pylsp.setup {}
lsp.rust_analyzer.setup {}
lsp.taplo.setup {}
lsp.tsserver.setup {}
lsp.vimls.setup {}
lsp.bashls.setup {}
