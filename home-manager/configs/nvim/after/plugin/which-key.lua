local wk = require("which-key")
local builtin = require('telescope.builtin')

wk.register({
    g = {
        name = "Git",
        g = { "<cmd>Neogit<cr>", "Open Neogit" },
        s = { "<cmd>lua require('gitsigns').stage_hunk()<cr>", "Stage hunk" },
        r = { "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Reset hunk" },
        S = { "<cmd>lua require('gitsigns').stage_buffer()<cr>", "Stage buffer" },
        b = { "<cmd>lua require('gitsigns').blame_line{full=true}<cr>", "Blame line" },
        t = { "<cmd>Gitsigns toggle_signs<cr>", "Toggle signs" },

    },
    t = {
        name = "Terminal",
        t = { "<cmd>ToggleTerm<cr>", "Toggle Terminal" },
        f = { "<cmd>ToggleTerm direction=float<cr>", "Toggle Floating Terminal" },
        g = { require("toggleterm_config").lazygit_toggle, "Toggle Lazygit" },
    },
    w = {
        name = "Window",
        v = { "<cmd>vsplit<cr>", "Vertical split" },
        V = { "<cmd>vsplit<cr><C-w>l", "Vertical split and follow" },
        s = { "<cmd>split<cr>", "Horizontal split" },
        S = { "<cmd>split<cr><C-w>j", "Horizontal split and follow" },

        h = { "<C-w>h", "Focus left" },
        j = { "<C-w>j", "Focus down" },
        k = { "<C-w>k", "Focus up" },
        l = { "<C-w>l", "Focus right" },
    },
    h = {
        name = "Harpoon",
        a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add mark" },
        h = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle menu" },
        t = { "<cmd>Telescope harpoon marks<cr>", "List marks" },
        j = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Previous mark" },
        k = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Next mark" },
    },
    b = {
        name = "Buffer",
        d = { "<cmd>bd<cr>", "Delete buffer" },
        t = { "<cmd>NvimTreeFindFile<cr>", "Focus file in nvim-tree" }
    },
    c = {
        name = "Code",
        b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint" },
        l = { "<cmd>lua require('dap').run_last()<CR>", "Run last debug" },
        d = { "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>", "Open diagnostic" },
        t = {
            name = "Test",
            n = { "<cmd>lua require('neotest').run.run()<CR>", "Run nearest" },
            f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Run file" },
            d = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", "Debug nearest test" },
            s = { "<cmd>lua require('neotest').run.stop()<CR>", "Stop test" },
            o = { "<cmd>lua require('neotest').output_panel.toggle()<CR>", "Toggle output panel" },
        }
    },
    f = {
        name = "Find",
        f = { builtin.find_files, "Find file" },
        s = { function() require('telescope').extensions.live_grep_args.live_grep_args() end, "Search keyword" },
        S = { builtin.current_buffer_fuzzy_find, "Search keyword in current buffer" },
        g = { builtin.git_files, "Find git file" },
        b = { builtin.buffers, "Find buffers" },
        h = { builtin.help_tags, "Find neovim doc" },
        t = { "<cmd>TodoTelescope<cr>", "Find TODOs" },
    },
    l = {
        name = "LSP",
        r = { "<cmd>LspRestart<CR>", "Restart LSP" },
        i = { "<cmd>LspInfo<CR>", "LSP Info" },
    },
    x = {
        name = "Trouble",
        x = { function() require('trouble').toggle() end, "Toggle Trouble" },
        w = { function() require('trouble').toggle("workspace_diagnostics") end, "Toggle Workspace Trouble" },
        d = { function() require('trouble').toggle("document_diagnostics") end, "Toggle Document Trouble" },
        l = { function() require('trouble').toggle("loclist") end, "Toggle Loclist Trouble" },
        q = { function() require('trouble').toggle("quickfix") end, "Toggle Quickfix Trouble" },
        t = { "<cmd>TodoTrouble<cr>", "Toggle Todo Trouble" },
    },
    C = {
        name = "ChatGPT",
        c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
        e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
        g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
        t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
        k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
        d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
        a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
        o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
        s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
        f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
        x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
        r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
        l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
    },
}, { prefix = "<leader>" })

wk.register({
    g = {
        name = "Git",
        s = { function() require('gitsigns').stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Stage selected hunk" },
        r = { function() require('gitsigns').reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Reset selected hunk" },
    },
}, { prefix = "<leader>", mode = "v" })
