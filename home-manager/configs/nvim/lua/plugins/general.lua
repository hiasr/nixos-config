return {
    -- UI and UX
    {
        --     -- TODO: Change this back once Zellij PR merged
        --     -- 'numToStr/Navigator.nvim',
        'hiasr/Navigator.nvim',
        config = function()
            require('Navigator').setup()
        end
    },
    -- { 'mrjones2014/smart-splits.nvim', lazy = false },
    -- Color Schemes
    { "catppuccin/nvim", as = "catppuccin" }, -- Theme
    {
        'nmac427/guess-indent.nvim',
        config = function() require('guess-indent').setup {} end,
    },
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
    -- 'github/copilot.vim',
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
}
