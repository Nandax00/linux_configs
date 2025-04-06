local branch_name_max_length = 30
local function truncate_git_branch(str)
  if (str:len() < branch_name_max_length) then
    return str
  end

  str = str:sub(1, branch_name_max_length)
  if not str:find("[-_]") then
    return str .. '…'
  end

  -- make the truncated output nicer by cutting off the last incomplete word
  local last_word_separator_idx = str:len() - str:reverse():find("[-_]")
  return str:sub(1, last_word_separator_idx) .. '…'
end

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
        max_length = 9999,
        mode = 2,
        use_mode_colors = true,
        symbols = { modified = " ●" },
      }
    },
    lualine_b = {
      {
        "branch",
        fmt = truncate_git_branch,
      },
      "diff",
    },
  },
}

require("mason").setup {}

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

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.proj = {
    install_info = {
        url = "~/.local/share/nvim/lazy/tree-sitter-proj",
        files = {"src/parser.c"},
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
    },
}

require("telescope").setup {
  defaults = {
    file_ignore_patterns = {
      ".mak",
      ".svg",
      "Makefile",
    },
    layout_strategy = "vertical",
    mappings = {
      n = {
        ["q"] = require("telescope.actions").close,
      },
    },
    sorting_strategy = "descending",
    wrap_results = true,
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
          ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
        },
      },
    },
  },
}
require("telescope").load_extension("live_grep_args")

require("toggleterm").setup {}

-- LSPs

local lsp = require("lspconfig")
lsp.clangd.setup {
  cmd = {
    "clangd",
    "--offset-encoding=utf-16"
  },
  filetypes = { 'c', 'cpp' },
}

vim.lsp.config.lua_ls = {
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
vim.lsp.enable({"cmake"})
vim.lsp.enable({"jsonls"})
vim.lsp.enable({"marksman"})
vim.lsp.enable({"lua_ls"})
vim.lsp.enable({"pylsp"})
vim.lsp.enable({"rust_analyzer"})
vim.lsp.enable({"taplo"})
vim.lsp.enable({"ts_ls"})
vim.lsp.enable({"vimls"})
vim.lsp.enable({"bashls"})
