vim.opt.syntax = "on"
vim.opt.filetype.indent = "on"
vim.opt.filetype.plugin = "on"
vim.opt.termguicolors = true

vim.g.mapleader = ","
vim.g.maplocalleader = "'"
vim.g.terminal_scrollback_buffer_size = 100000
vim.g.editorconfig = false

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "melange" } },
}

require("nvim_plugin_setup")

vim.opt.autoindent = true
vim.opt.backup = false
vim.opt.binary = true
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.display = "uhex"
vim.opt.expandtab = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumheight = 10
vim.opt.pumwidth = 10
vim.opt.ruler = true
vim.opt.scrolloff = 5
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.showcmd = true
vim.opt.showmode = false
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.startofline = true
vim.opt.tabpagemax = 100
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full"

vim.filetype.add({
    extension = {
        proj = "proj",
        robot = "robot",
    },
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.opt_local.colorcolumn = "120"
    vim.opt_local.expandtab = false
    vim.api.nvim_buf_set_keymap(0, "n", "<localleader>c", "I// <ESC>", { noremap = true })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gdscript",
  callback = function()
    vim.opt_local.foldlevel = 99
    vim.opt_local.foldmethod = "expr"
    vim.api.nvim_buf_set_keymap(0, "n", "<localleader>r", ":GodotRun<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<localleader>t", ":GodotRunCurrent<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<localleader>c", "I# <ESC>", { noremap = true })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.colorcolumn = "120"
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    -- Open a file or go down the hierarchy
    vim.api.nvim_buf_set_keymap(0, "n", "l", "<CR>", {})
    -- Go up the hierarchy, 8th line should be ".."
    vim.api.nvim_buf_set_keymap(0, "n", "h", "8G<CR>", {})
    -- Close preview (opened by `p`)
    vim.api.nvim_buf_set_keymap(0, "n", "P", "<C-W>z", { noremap = true })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "plantuml",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "proj",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.list = true
    vim.opt_local.wrap = false
    vim.api.nvim_buf_set_keymap(0, "n", "<localleader>c", "I# <ESC>", { noremap = true })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "robot",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<localleader>c", "I# <ESC>", { noremap = true })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<localleader>c", "I// <ESC>", { noremap = true })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end
})

-- Insert mode mappings
vim.api.nvim_set_keymap("i", "jk", "<ESC>", {})
--  Remap the completion menu (used by LSPs)
vim.api.nvim_set_keymap("i", "<C-K>", "<C-X><C-O>", { noremap = true })
--  Quickly convert word under the cursor to uppercase
vim.api.nvim_set_keymap("i", "<C-U>", "<ESC>viwUea", { noremap = true })

-- Normal mode mappings
vim.api.nvim_set_keymap("n", "<leader>qq", ":nohlsearch<CR>", { noremap = true })
--  Diagnostic Disable
vim.api.nvim_set_keymap("n", "<leader>dd", ":lua vim.diagnostic.hide()<CR>", { noremap = true })
--  Diagnostic Enable
vim.api.nvim_set_keymap("n", "<leader>de", ":lua vim.diagnostic.show()<CR>", { noremap = true })
--  Telescope mappings
--    <C-X> - open file in horizontal split
--    <C-V> - open file in vertical split
--    <C-T> - open file in new tab
--  Go to definition, using an LSP
vim.api.nvim_set_keymap("n", "<leader>gd", ":Telescope lsp_definitions<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gi", ":Telescope lsp_implementations<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gr", ":Telescope lsp_references include_current_line=true<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true })
--  As in "find symbol"
vim.api.nvim_set_keymap("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", { noremap = true })
--  Open file under the cursor, move split to the right
vim.api.nvim_set_keymap("n", "<leader>wf", "<C-W>f<C-W>L", { noremap = true })
--  Copies the path of the current file to the clipboard
vim.api.nvim_set_keymap("n", "<leader>pwd", ":let @+=expand('%:p')<CR>:echo expand('%:p')<CR>", { noremap = true })
--  Trim trailing whitespace
vim.api.nvim_set_keymap("n", "<leader>tr", ":%s/\\s\\+$//e<CR>", { noremap = true })
--  Edit Lua config
vim.api.nvim_set_keymap("n", "<leader>el", ":vsplit ~/.config/nvim/init.lua<CR>", { noremap = true })
--  Edit Plugin settings
vim.api.nvim_set_keymap("n", "<leader>ep", ":vsplit ~/.config/nvim/lua/nvim_plugin_setup.lua<CR>", { noremap = true })

-- Visual mode mappings
--  Wrap selection in apostrophe marks
vim.api.nvim_set_keymap("v", "<leader>\"", "<ESC>`<i\"<ESC>`>a\"<ESC>v", { noremap = true })

-- Everything color related
--  Theme
vim.opt.background = "dark"
vim.cmd.colorscheme "melange"

--  Highlight trailing whitespaces across all files
vim.cmd([[
match TrailingWhitespace /\s\+$/
highlight link TrailingWhitespace   ErrorMsg
]])
