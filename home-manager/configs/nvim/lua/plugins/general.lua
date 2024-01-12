return {
    -- UI and UX
    -- { 'akinsho/bufferline.nvim',
    --     version = "v4.1.0",
    --     dependencies = 'kyazdani42/nvim-web-devicons',
    --     config = function()
    --         require("bufferline").setup()
    --     end
    -- },
    {
        'numToStr/Navigator.nvim',
    },
    -- {
    --     "m4xshen/hardtime.nvim",
    --     dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    --     opts = {}
    -- },

    -- Color Schemes
    { "catppuccin/nvim", as = "catppuccin" }, -- Theme

    -- Additional applications
    {
        'nvim-telescope/telescope.nvim',
        version = "0.1.1",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim'
        },
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
        version = "v2.5.0",
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
    {
        "ggandor/leap.nvim",
        config = function()
            require('leap').add_default_mappings()
        end,
        dependencies = {
            "tpope/vim-repeat",
        }
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

}
