return {
    -- LSP stuff
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- DAP stuff
    {
        'mfussenegger/nvim-dap',
        version = "0.6.0",
        dependencies = {
           "mfussenegger/nvim-dap-python",
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim",
        },
        config = function()
            require("dap-config").setup()
        end
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
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },

    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup() end
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
