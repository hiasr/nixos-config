local wk = require("which-key")
local builtin = require('telescope.builtin')


-- Define the toggle diffview function
local function toggle_diffview()
    if next(require('diffview.lib').views) == nil then
        vim.cmd('DiffviewOpen')
    else
        vim.cmd('DiffviewClose')
    end
end

wk.add(
{
    { "<leader>C", group = "ChatGPT" },
    { "<leader>Cc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
    { "<leader>b", group = "Buffer" },
    { "<leader>bd", "<cmd>bd<cr>", desc = "Delete buffer" },
    { "<leader>bt", "<cmd>NvimTreeFindFile<cr>", desc = "Focus file in nvim-tree" },
    { "<leader>c", group = "Code" },
    { "<leader>cb", "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
    { "<leader>cd", "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>", desc = "Open diagnostic" },
    { "<leader>cl", "<cmd>lua require('dap').run_last()<CR>", desc = "Run last debug" },
    { "<leader>ct", group = "Test" },
    { "<leader>ctd", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", desc = "Debug nearest test" },
    { "<leader>ctf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Run file" },
    { "<leader>ctl", "<cmd>lua require('neotest').run.run_last()<CR>", desc = "Run last test again" },
    { "<leader>ctn", "<cmd>lua require('neotest').run.run()<CR>", desc = "Run nearest" },
    { "<leader>cto", "<cmd>lua require('neotest').output_panel.toggle()<CR>", desc = "Toggle output panel" },
    { "<leader>cts", "<cmd>lua require('neotest').run.stop()<CR>", desc = "Stop test" },
    { "<leader>ctt", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "Toggle summary" },
    { "<leader>f", group = "Find" },
    { "<leader>fS", builtin.current_buffer_fuzzy_find, desc = "Search keyword in current buffer" },
    { "<leader>fb", builtin.buffers, desc = "Find buffers" },
    { "<leader>ff", builtin.find_files, desc = "Find file" },
    { "<leader>fg", builtin.git_files, desc = "Find git file" },
    { "<leader>fh", builtin.help_tags, desc = "Find neovim doc" },
    { "<leader>fs", function() require('telescope').extensions.live_grep_args.live_grep_args() end, desc = "Search keyword" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    { "<leader>g", group = "Git" },
    { "<leader>gS", "<cmd>lua require('gitsigns').stage_buffer()<cr>", desc = "Stage buffer" },
    { "<leader>gb", "<cmd>lua require('gitsigns').blame_line{full=true}<cr>", desc = "Blame line" },
    { "<leader>gd", toggle_diffview, desc = "Toggle Diffview" },
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
    { "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset hunk" },
    { "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage hunk" },
    { "<leader>gt", "<cmd>Gitsigns toggle_signs<cr>", desc = "Toggle signs" },
    { "<leader>h", group = "Harpoon" },
    { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add mark" },
    { "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle menu" },
    { "<leader>hj", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Previous mark" },
    { "<leader>hk", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Next mark" },
    { "<leader>ht", "<cmd>Telescope harpoon marks<cr>", desc = "List marks" },
    { "<leader>l", group = "LSP" },
    { "<leader>li", "<cmd>LspInfo<CR>", desc = "LSP Info" },
    { "<leader>lr", "<cmd>LspRestart<CR>", desc = "Restart LSP" },
    { "<leader>t", group = "Terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Floating Terminal" },
    { "<leader>tg", function() require('toggleterm_config').lazygit_toggle() end, desc = "Toggle Lazygit" },
    { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    { "<leader>w", group = "Window" },
    { "<leader>wS", "<cmd>split<cr><C-w>j", desc = "Horizontal split and follow" },
    { "<leader>wV", "<cmd>vsplit<cr><C-w>l", desc = "Vertical split and follow" },
    { "<leader>wh", "<C-w>h", desc = "Focus left" },
    { "<leader>wj", "<C-w>j", desc = "Focus down" },
    { "<leader>wk", "<C-w>k", desc = "Focus up" },
    { "<leader>wl", "<C-w>l", desc = "Focus right" },
    { "<leader>ws", "<cmd>split<cr>", desc = "Horizontal split" },
    { "<leader>wv", "<cmd>vsplit<cr>", desc = "Vertical split" },
    { "<leader>x", group = "Trouble" },
    -- { "<leader>xd", <function 1>, desc = "Toggle Document Trouble" },
    -- { "<leader>xl", <function 1>, desc = "Toggle Loclist Trouble" },
    -- { "<leader>xq", <function 1>, desc = "Toggle Quickfix Trouble" },
    -- { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Toggle Todo Trouble" },
    -- { "<leader>xw", <function 1>, desc = "Toggle Workspace Trouble" },
    -- { "<leader>xx", <function 1>, desc = "Toggle Trouble" },
    {
      mode = { "n", "v" },
      { "<leader>Ca", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests" },
      { "<leader>Cd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring" },
      { "<leader>Ce", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction" },
      { "<leader>Cf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs" },
      { "<leader>Cg", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction" },
      { "<leader>Ck", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords" },
      { "<leader>Cl", "<cmd>ChatGPTRun code_readability_analysis<CR>", desc = "Code Readability Analysis" },
      { "<leader>Co", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code" },
      { "<leader>Cr", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit" },
      { "<leader>Cs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize" },
      { "<leader>Ct", "<cmd>ChatGPTRun translate<CR>", desc = "Translate" },
      { "<leader>Cx", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code" },
    },
  }
)

wk.add({
    {
        mode = {"v"},
        {"<leader>g", group="Git"},
        {"<leader>gs", function() require('gitsigns').stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, desc = "Stage selected hunk" },
        {"<leader>gr", function() require('gitsigns').reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, desc = "Reset selected hunk" },
    }
})
