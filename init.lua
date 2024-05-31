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
    completion = {enable = true},
}
lsp.jedi_language_server.setup{completion = {enable = true}}
lsp.jsonls.setup{completion = {enable = true}}
lsp.marksman.setup{completion = {enable = true}}
lsp.rust_analyzer.setup{completion = {enable = true}}
lsp.vimls.setup{completion = {enable = true}}
