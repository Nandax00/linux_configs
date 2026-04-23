vim.pack.add({
  { src = "https://github.com/tpope/vim-fugitive", },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/williamboman/mason.nvim" },
  { src = "https://github.com/savq/melange-nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/aklt/plantuml-syntax" },
  { src = "https://github.com/nvim-telescope/telescope.nvim", },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim" },
  { src = "https://github.com/akinsho/toggleterm.nvim" },
})

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

vim.lsp.config.clangd = {
  filetypes = { 'c', 'cpp', 'h', 'hpp' },
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

vim.lsp.config.pylsp = {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {"W391"},
          maxLineLength = 100
        }
      }
    }
  },
  cmd = {"pylsp"},
  filetypes = {"python"}
}

vim.lsp.enable("bashls")
vim.lsp.enable("clangd")
vim.lsp.enable("cmake")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("pylsp")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("taplo")
vim.lsp.enable("ts_ls")
vim.lsp.enable("vimls")
