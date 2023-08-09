local keymap = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}
local expr_opts = {noremap = true, expr = true, silent = true}


keymap("n", "<S-h>", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", default_opts)
keymap("n", "<S-l>", "<cmd>lua require('harpoon.ui').nav_next()<cr>", default_opts)


-- Map leader to space
vim.g.mapleader = " "

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

-- Switch between splits
require('Navigator').setup()
keymap("n", "<C-h>", ":NavigatorLeft<CR>",default_opts)
keymap("n", "<C-j>", ":NavigatorDown<CR>",default_opts)
keymap("n", "<C-k>", ":NavigatorUp<CR>",default_opts)
keymap("n", "<C-l>", ":NavigatorRight<CR>",default_opts)
keymap("n", "<C-x>",":q<CR>",default_opts)
keymap("n", "<C-w>",":lua require('bufdelete').bufdelete(0, true)<CR>",default_opts)

-- Toggle Nvim-tree
vim.keymap.set("n", "<C-n>","<cmd>NvimTreeToggle<cr>", default_opts)

-- Toggleterm.nvim
vim.keymap.set('n', '<C-t>', "<Cmd>ToggleTerm<CR>", default_opts)
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-x>', "<Cmd>q<CR>", opts)
  vim.keymap.set('t', '<C-t>', "<Cmd>ToggleTerm<CR>", opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

vim.keymap.set('n', "<A-h>", '<CMD>NavigatorLeft<CR>',default_opts)
vim.keymap.set('n', "<A-l>", '<CMD>NavigatorRight<CR>',default_opts)
vim.keymap.set('n', "<A-k>", '<CMD>NavigatorUp<CR>',default_opts)
vim.keymap.set('n', "<A-j>", '<CMD>NavigatorDown<CR>',default_opts)
vim.keymap.set('n', "<A-p>", '<CMD>NavigatorPrevious<CR>',default_opts)

-- Nvim-lspconfig
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local bufopts = { noremap=true, silent=true}
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', builtin.lsp_definitions, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', builtin.lsp_implementations, bufopts)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wl', function()
print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', 'gr', builtin.lsp_references, bufopts)
vim.keymap.set('n', '<space>cf', function() vim.lsp.buf.format { async = true } end, bufopts)

-- Nvim-dap
local dap = require('dap')
vim.keymap.set('n', '<F5>', dap.continue, default_opts)
vim.keymap.set('n', '<F10>', dap.step_over, default_opts)
vim.keymap.set('n', '<F11>', dap.step_into, default_opts)
vim.keymap.set('n', '<F12>', dap.step_out, default_opts)
