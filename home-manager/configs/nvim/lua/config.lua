-- Set colorscheme
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({
    term_colors = true;
 --   transparent_background = true;
})
vim.cmd [[colorscheme catppuccin]]


vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1


