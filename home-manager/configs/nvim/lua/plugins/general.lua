return {
    -- UI and UX
    -- {
    --     -- TODO: Change this back once Zellij PR merged
    --     -- 'numToStr/Navigator.nvim',
    --     'dynamotn/Navigator.nvim',
    -- },

    { 'mrjones2014/smart-splits.nvim' },
    -- Color Schemes
    { "catppuccin/nvim", as = "catppuccin" }, -- Theme

    -- Additional applications
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim',
        },
        config = function()
            local lga_actions = require('telescope-live-grep-args.actions')
            require('telescope').load_extension('live_grep_args')
            require('telescope').setup {
                extensions = {
                    live_grep_args = {
                        mappings = { -- extend mappings
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            },
                        },
                    }
                }
            }
        end
    },
    {
        "j-hui/fidget.nvim",
        opts = {}
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
        }
    },
    {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
        config = function()
            require("nvim-tree").setup()
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup()
        end
    },
    {
        'NeogitOrg/neogit',                  -- Magit for Neovim
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
        },
        config = true
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' }
    },
    {
        "goolord/alpha-nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("alpha").setup(require("alpha.themes.dashboard").opts)
        end,
    },
    {
        "epwalsh/obsidian.nvim",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            dir = "~/Obsidian",
            completion = {
                nvim_cmp = true,
            }
        }
    },
    -- {
    --     "ggandor/leap.nvim",
    --     config = function()
    --         require('leap').add_default_mappings()
    --     end,
    --     dependencies = {
    --         "tpope/vim-repeat",
    --     }
    -- },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            modes = {
                char = {
                    jump_labels = true,
                    multi_line = false,
                    autohide = true,
                }
            }
        },
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            {
                "S",
                mode = { "n", "x", "o" },
                function() require("flash").treesitter() end,
                desc =
                "Flash Treesitter"
            },
            {
                "r",
                mode = "o",
                function() require("flash").remote() end,
                desc =
                "Remote Flash"
            },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc =
                "Treesitter Search"
            },
            {
                "<c-s>",
                mode = { "c" },
                function() require("flash").toggle() end,
                desc =
                "Toggle Flash Search"
            },
        },
    },

    -- Misc
    'tpope/vim-obsession',
    'github/copilot.vim',
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
        end
    },
    {
        "karb94/neoscroll.nvim",
        config = function()
            require('neoscroll').setup {}
        end
    },
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup {
                api_key_cmd = "pwd",
                api_host_cmd = "echo http://localhost:4000",
                popup_input = {
                    submit = "<CR>",
                },
                openai_params = {
                    model = "claude-haiku",
                },
                openai_edit_params = {
                    model = "gpt4",
                }
            }
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    }

}
