return {

    {
        'neovim/nvim-lspconfig',
    },
    -- {
    --     "olimorris/codecompanion.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-treesitter/nvim-treesitter",
    --         "hrsh7th/nvim-cmp",                                                                    -- Optional: For using slash commands and variables in the chat buffer
    --         "nvim-telescope/telescope.nvim",                                                       -- Optional: For using slash commands
    --         { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }, -- Optional: For prettier markdown rendering
    --         { "stevearc/dressing.nvim",                    opts = {} },                            -- Optional: Improves `vim.ui.select`
    --     },
    --     opts = {
    --         display = {
    --             diff = {
    --                 -- provider = "mini_diff",
    --             },
    --         },
    --         strategies = {
    --             chat = {
    --                 adapter = "",
    --             },
    --             inline = {
    --                 adapter = "",
    --             },
    --         },
    --     },
    --     config = true
    -- },
    -- {
    --     "yetone/avante.nvim",
    --     event = "VeryLazy",
    --     lazy = false,
    --     version = false, -- set this if you want to always pull the latest change
    --     opts = {
    --         provider = "copilot",
    --         auto_suggestions_provider = "copilot",
    --         hints = {
    --             enabled = false
    --         }
    --     },
    --     build = "make",
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         "stevearc/dressing.nvim",
    --         "nvim-lua/plenary.nvim",
    --         "MunifTanjim/nui.nvim",
    --         --- The below dependencies are optional,
    --         "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    --         -- "zbirenbaum/copilot.lua", -- for providers='copilot'
    --         {
    --             "HakonHarnes/img-clip.nvim",
    --             event = "VeryLazy",
    --             opts = {
    --                 default = {
    --                     embed_image_as_base64 = false,
    --                     prompt_for_file_name = false,
    --                     drag_and_drop = {
    --                         insert_mode = true,
    --                     },
    --                     use_absolute_path = true,
    --                 },
    --             },
    --         },
    --         {
    --             'MeanderingProgrammer/render-markdown.nvim',
    --             opts = {
    --                 file_types = { "markdown", "Avante" },
    --             },
    --             ft = { "markdown", "Avante" },
    --         },
    --     },
    -- },
    {
        'nvimtools/none-ls.nvim',
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
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({
                                    async = false,
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
                    "ts_ls",
                    "clangd",
                    "elixirls",
                    "ruff"
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
                ["ruff"] = function ()
                    require("lspconfig").ruff.setup({
                        init_options = {
                            settings = {
                                -- Modification to any of these settings has no effect.
                                enable = true,
                                organizeImports       = true,
                                fixAll                = true,
                                lint = {
                                    enable = true,
                                    run    = 'onType',
                            },
                        },
                    }
                });
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
        version = '^5', -- Recommended
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
    'tpope/vim-surround',
    'sindrets/diffview.nvim',
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
        keys = {
            {
              "<leader>xx",
              "<cmd>Trouble diagnostics toggle<cr>",
              desc = "Diagnostics (Trouble)",
            },
            {
              "<leader>xX",
              "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
              desc = "Buffer Diagnostics (Trouble)",
            },
            {
              "<leader>cs",
              "<cmd>Trouble symbols toggle focus=false<cr>",
              desc = "Symbols (Trouble)",
            },
            {
              "<leader>cl",
              "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
              desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
              "<leader>xL",
              "<cmd>Trouble loclist toggle<cr>",
              desc = "Location List (Trouble)",
            },
            {
              "<leader>xQ",
              "<cmd>Trouble qflist toggle<cr>",
              desc = "Quickfix List (Trouble)",
            },
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
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            require('mini.ai').setup();
            require('mini.surround').setup();
            require('mini.comment').setup();
            require('mini.pairs').setup();
            -- require('mini.diff').setup({source = require('mini.diff').gen_source.none(), options = {algorithm = 'patience'}});

        end
    },
}
