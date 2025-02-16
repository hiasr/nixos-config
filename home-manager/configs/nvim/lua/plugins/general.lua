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
    {
        "folke/zen-mode.nvim",
    },
    {
        "andrewferrier/wrapping.nvim",
        config = function()
            require("wrapping").setup()
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
            local open_with_trouble = require("trouble.sources.telescope").open
            require('telescope').load_extension('live_grep_args')
            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = { ["<c-t>"] = open_with_trouble },
                        n = { ["<c-t>"] = open_with_trouble },
                    },
                },
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
        "epwalsh/obsidian.nvim",
        version = "*", -- use latest release instead of latest commit
        lazy = true,
        -- ft = "markdown",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        event = {
            -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
            -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
            -- refer to `:h file-pattern` for more examples
            "BufReadPre " .. vim.fn.expand "~" .. "/obsidian/*.md",
            "BufReadPre " .. vim.fn.expand "~" .. "/Obsidian/*.md",
        },
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",

            -- see below for full list of optional dependencies 👇
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/obsidian",

                },
            },
            notes_dir = "00 - Own Notes",
            note_id_func = function(title)
                return title
            end,
            daily_notes = {
                folder = "01 - Dailies"
            },
            ui = {
                bullets = { char = "-", hl_group = "ObsidianBullet" },
            }
        },
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
        -- event = "VeryLazy",
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
