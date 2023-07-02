local wk = require("which-key")
local builtin = require('telescope.builtin')

wk.register({
    g = {
        name = "Git",
        g = { "<cmd>Neogit<cr>", "Open Neogit" }
    },
    t = {
        name = "Terminal",
        t = { "<cmd>ToggleTerm<cr>", "Toggle Terminal" }
    },
    w = {
        name = "Window",
        v = { "<cmd>vsplit<cr>", "Vertical split" },
        V = {"<cmd>vsplit<cr><C-w>l", "Vertical split and follow" },
        s = { "<cmd>split<cr>", "Horizontal split" },
        S = { "<cmd>split<cr><C-w>j", "Horizontal split and follow" },

        h = { "<C-w>h", "Focus left" },
        j = { "<C-w>j", "Focus down" },
        k = { "<C-w>k", "Focus up" },
        l = { "<C-w>l", "Focus right" },
    },
    b = {
        name = "Buffer",
        d = { "<cmd>bd<cr>", "Delete buffer" },
    },
    c = {
        name = "Code",
        b = {"<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint"},
        l = {"<cmd>lua require('dap').run_last()<CR>", "Run last debug"},
        d = {"<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>", "Open diagnostic"},
    },
    f = {
        name = "Find",
        f = {builtin.find_files, "Find file"},
        s = {builtin.live_grep, "Search keyword"},
        g = {builtin.git_files, "Find git file"},
        b = {builtin.buffers, "Find buffers"},
        h = {builtin.help_tags, "Find neovim doc"},
    }


}, { prefix = "<leader>"})
