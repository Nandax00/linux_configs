require("telescope").setup{
    defaults = {
        initial_mode = "normal",
        layout_strategy = "vertical",
        sorting_strategy = "descending",
        wrap_results = true,
        -- file_ignore_patterns = { ".mk" }
    },
}

require("mason").setup{}

local lsp = require("lspconfig")
local coq = require("coq")
lsp.clangd.setup{
    coq.lsp_ensure_capabilities(),
    cmd = {
        "clangd",
        "--offset-encoding=utf-16"
    }
}
lsp.jedi_language_server.setup{coq.lsp_ensure_capabilities()}
lsp.jsonls.setup{coq.lsp_ensure_capabilities()}
lsp.marksman.setup{coq.lsp_ensure_capabilities()}
lsp.rust_analyzer.setup{coq.lsp_ensure_capabilities()}
