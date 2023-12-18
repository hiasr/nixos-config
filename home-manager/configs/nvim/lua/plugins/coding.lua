return {
    -- LSP stuff
    {
        'neovim/nvim-lspconfig',
    },
    {
        'nvimtools/none-ls.nvim',
        config = function()
            require("null-ls").setup({
                sources = {
                    require("null-ls").builtins.formatting.black,
                    require("null-ls").builtins.formatting.ocamlformat,
                    -- require("null-ls").builtins.diagnostics.flake8;
                }
            })
        end
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
                    "pyright",
                    -- "rust_analyzer",
                    "nil_ls",
                    "lua_ls",
                    "jdtls",
                    "tsserver",
                    "ocamllsp",
                    "clangd",
                }
            }
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    if server_name == "rust_analyzer" then
                        return
                    end
                    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
                        .make_client_capabilities())
                    require("lspconfig")[server_name].setup { capabilities = capabilities }
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
                -- ["rust_analyzer"] = function()
                --     local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol
                --         .make_client_capabilities())
                --     require("lspconfig").rust_analyzer.setup {
                --         capabilities = capabilities,
                --         settings = {
                --             ["rust-analyzer"] = {
                --                 check = {
                --                     command = "clippy"
                --                 },
                --                 checkOnSave = {
                --                     command = "clippy"
                --                 },
                --                 cargo = {
                --                     loadOutDirsFromCheck = true
                --                 },
                --                 procMacro = {
                --                     enable = true
                --                 },
                --                 diagnostics = {
                --                     enable = true,
                --                     enableExperimental = true,
                --                 },
                --                 assist = {
                --                     importGranularity = "module",
                --                     importPrefix = "by_self",
                --                 },
                --                 inlayHints = {
                --                     chainingHints = true,
                --                     parameterHints = true,
                --                     typeHints = true,
                --                 },
                --             }
                --         }
                --     }
                -- end
            }
        end
    },
    -- DAP stuff
    {
        'mfussenegger/nvim-dap',
        dependencies = {
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
        version = '^3', -- Recommended
        ft = { 'rust' },
    },
    -- Autocomplete stuff
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',

    -- General coding
    'sbdchd/neoformat',
    'L3MON4D3/LuaSnip',
    'elkowar/yuck.vim',
    'tpope/vim-surround',
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
                    require("neotest-go"),
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
