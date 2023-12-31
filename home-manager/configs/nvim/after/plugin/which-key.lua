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
    h = {
        name = "Harpoon",
        a = {"<cmd>lua require('harpoon.mark').add_file()<cr>", "Add mark"},
        h = {"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle menu"},
        t = {"<cmd>Telescope harpoon marks<cr>", "List marks"},
        j = {"<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Previous mark"},
        k = {"<cmd>lua require('harpoon.ui').nav_next()<cr>", "Next mark"},
    },
    b = {
        name = "Buffer",
        d = { "<cmd>bd<cr>", "Delete buffer" },
        t = { "<cmd>NvimTreeFindFile<cr>", "Focus file in nvim-tree"}
    },
    c = {
        name = "Code",
        b = {"<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint"},
        l = {"<cmd>lua require('dap').run_last()<CR>", "Run last debug"},
        d = {"<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>", "Open diagnostic"},
        t = {
            name = "Test",
            n = {"<cmd>lua require('neotest').run.run()<CR>", "Run nearest"},
            f = {"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Run file"},
            d = {"<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", "Debug nearest test"},
            s = {"<cmd>lua require('neotest').run.stop()<CR>", "Stop test"},
            o = {"<cmd>lua require('neotest').output_panel.toggle()<CR>", "Toggle output panel"},
        }
    },
    f = {
        name = "Find",
        f = {builtin.find_files, "Find file"},
        s = {builtin.live_grep, "Search keyword"},
        g = {builtin.git_files, "Find git file"},
        b = {builtin.buffers, "Find buffers"},
        h = {builtin.help_tags, "Find neovim doc"},
    },
    l = {
        name = "LSP",
        r = {"<cmd>LspRestart<CR>", "Restart LSP"},
        i = {"<cmd>LspInfo<CR>", "LSP Info"},
    }


}, { prefix = "<leader>"})
