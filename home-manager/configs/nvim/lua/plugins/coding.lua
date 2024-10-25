return {
    -- LSP stuff
    {
        'neovim/nvim-lspconfig',
    },
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            local lsp_formatter_filter = function(client)
                if client.name == "tsserver" then
                    return false
                end
                return true
            end
            require("null-ls").setup({
                sources = {
                    require("null-ls").builtins.formatting.ocamlformat,
                    require("null-ls").builtins.formatting.goimports,
                    require("null-ls").builtins.formatting.prettier,
                    require("null-ls").builtins.formatting.black,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ async = false,
                                filter = lsp_formatter_filter,
                                bufnr = bufnr
                            })
                            end,
                        })
                    end
                end,
            })
        end
    },
    {
        'nvimdev/lspsaga.nvim',
        config = function()
            require('lspsaga').setup({
                symbol_in_winbar = {
                    enable = false,
                },
                lightbulb = {
                    enable = false,
                },
            })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        }
    },
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "bashls",
                    "dockerls",
                    "gopls",
                    "basedpyright",
                    -- "pyright",
                    -- "rust_analyzer",
                    "nil_ls",
                    "lua_ls",
                    "jdtls",
                    "tsserver",
                    "clangd",
                    "elixirls",
                }
            }
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    if server_name == "jdtls" then
                        return
                    end
                    if server_name == "rust_analyzer" then
                        return
                    end
                    if server_name == "basedpyright" then
                        return
                    end
                    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
                        .make_client_capabilities())
                    require("lspconfig")[server_name].setup { capabilities = capabilities }
                end,
                ["basedpyright"] = function()
                    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
                        .make_client_capabilities())
                    require("lspconfig")["basedpyright"].setup {
                        capabilities = capabilities,
                        root_dir = function()
                            return vim.fn.getcwd()
                        end,
                        settings = {
                            basedpyright = {
                                analysis = {
                                    typeCheckingMode = "standard",
                                }
                            }
                        }
                    }
                end,
                ["lua_ls"] = function()
                    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
                        .make_client_capabilities())
                    require("lspconfig").lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'vim' },
                                }
                            }
                        }
                    }
                end,
            }
        end
    },
    {
        "mfussenegger/nvim-jdtls",
        dependencies = {
            "williamboman/mason.nvim",
        }
    },
    -- DAP stuff
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim",
        },
        config = function()
            require("dap-config").setup()
        end
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            'mfussenegger/nvim-dap',
        }
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap"
        },
        config = function()
            require("mason-nvim-dap").setup()
        end
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
    },
    -- Autocomplete stuff
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',

    -- General coding
    'L3MON4D3/LuaSnip',
    'elkowar/yuck.vim',
    'tpope/vim-surround',
    'sindrets/diffview.nvim',
    'tpope/vim-fugitive',
    {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup()
        end
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    {
        "ThePrimeagen/harpoon",
        requires = {
            "nvim-lua/plenary.nvim",
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('telescope').load_extension('harpoon')
            require('harpoon').setup({
                tabline = true
            })
        end
    },
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup() end
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-go",
            "marilari88/neotest-vitest",
            "nvim-neotest/neotest-python",
            "jfpedroza/neotest-elixir",
        },
        config = function()
            -- get neotest namespace (api call creates or returns namespace)
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        local message =
                            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                        return message
                    end,
                },
            }, neotest_ns)
            require("neotest").setup({
                -- your neotest config here
                adapters = {
                    require("neotest-python"),
                    require("neotest-go"),
                    require('rustaceanvim.neotest'),
                    require("neotest-vitest"),
                    require("neotest-elixir"),
                },
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function() require("nvim-ts-autotag").setup() end
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
}
