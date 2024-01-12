require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "rust", "python", "java", "haskell", "markdown", "markdown_inline"},
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true
    }
}
