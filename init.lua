require('nvim-treesitter.configs').setup{
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

require("telescope").setup{
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

require("mason").setup{}

local lsp = require("lspconfig")
lsp.clangd.setup{
    cmd = {
        "clangd",
        "--offset-encoding=utf-16"
    },
}
lsp.jsonls.setup{}
lsp.marksman.setup{}
lsp.lua_ls.setup{}
lsp.pylsp.setup{}
lsp.rust_analyzer.setup{}
lsp.taplo.setup{}
lsp.tsserver.setup{}
lsp.vimls.setup{}
lsp.bashls.setup{}
