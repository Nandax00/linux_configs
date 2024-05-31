require("telescope").setup{
    defaults = {
        initial_mode = "normal",
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
lsp.jedi_language_server.setup{}
lsp.jsonls.setup{}
lsp.marksman.setup{}
lsp.lua_ls.setup{}
lsp.rust_analyzer.setup{}
lsp.vimls.setup{}
