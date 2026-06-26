vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

-- No setup() needed unless you want a custom install_dir.
-- Install the parsers you want (async; replaces ensure_installed):
require("nvim-treesitter").install({
  "lua", "rust", "zig", "sql", "bash", "json", "markdown", "markdown_inline", "php"
})

-- Highlighting is core's job now — enable per filetype:
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "rust", "zig", "sql", "bash", "json", "markdown", "php" },
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
