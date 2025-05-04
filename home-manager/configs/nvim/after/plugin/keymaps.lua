local keymap = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- Harpoon keybindings
keymap("n", "<S-h>", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", default_opts)
keymap("n", "<S-l>", "<cmd>lua require('harpoon.ui').nav_next()<cr>", default_opts)
keymap("n", "<M-1>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", default_opts)
keymap("n", "<M-2>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", default_opts)
keymap("n", "<M-3>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", default_opts)
keymap("n", "<M-4>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", default_opts)
keymap("n", "<M-5>", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", default_opts)
keymap("n", "<M-6>", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", default_opts)
keymap("n", "<M-7>", "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", default_opts)
keymap("n", "<M-8>", "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", default_opts)
keymap("n", "<M-9>", "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", default_opts)
keymap("n", "<M-0>", "<cmd>lua require('harpoon.ui').nav_file(10)<cr>", default_opts)
keymap("n", "<C-S-!>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", default_opts)
keymap("n", "<C-S-@>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", default_opts)
keymap("n", "<C-S-#>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", default_opts)
keymap("n", "<C-S-$>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", default_opts)
keymap("n", "<C-S-%>", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", default_opts)

keymap("n", "<C-S-n>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", default_opts)
keymap("n", "<C-S-e>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", default_opts)
keymap("n", "<C-S-i>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", default_opts)
keymap("n", "<C-S-o>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", default_opts)
-- Map leader to space
vim.g.mapleader = " "


-- Codecompanion
vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR><ESC>", default_opts)

-- Switch between splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
-- resizing splits
vim.keymap.set('n', '<C-S-Left>', require('smart-splits').resize_left)
vim.keymap.set('n', '<C-S-Down>', require('smart-splits').resize_down)
vim.keymap.set('n', '<C-S-Up>', require('smart-splits').resize_up)
vim.keymap.set('n', '<C-S-Right>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)

-- require('Navigator').setup()
-- keymap("n", "<C-h>", ":NavigatorLeft<CR>",default_opts)
-- keymap("n", "<C-j>", ":NavigatorDown<CR>",default_opts)
-- keymap("n", "<C-k>", ":NavigatorUp<CR>",default_opts)
-- keymap("n", "<C-l>", ":NavigatorRight<CR>",default_opts)
--
-- keymap("n", "<C-Left>", "<cmd>NavigatorLeft<CR>",default_opts)
-- keymap("n", "<C-Down>", "<cmd>NavigatorDown<CR>",default_opts)
-- keymap("n", "<C-Up>", "<cmd>NavigatorUp<CR>",default_opts)
-- keymap("n", "<C-Right>", "<cmd>NavigatorRight<CR>",default_opts)
keymap("n", "<C-x>","<cmd>q<CR>",default_opts)

-- Toggle Nvim-tree
vim.keymap.set("n", "<C-n>","<cmd>NvimTreeToggle<cr>", default_opts)

-- Toggleterm.nvim
vim.keymap.set('n', '<C-t>', "<Cmd>ToggleTerm<CR>", default_opts)
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-x>', "<Cmd>q<CR>", opts)
  vim.keymap.set('t', '<C-t>', "<Cmd>ToggleTerm<CR>", opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

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
vim.keymap.set('n', 'gd', builtin.lsp_definitions, bufopts)
vim.keymap.set('n', 'gD', '<cmd>Lspsaga peek_definition<cr>', bufopts)
vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, bufopts)
vim.keymap.set('n', 'gT', '<cmd>Lspsaga peek_type_definition<cr>', bufopts)
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', bufopts)
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', 'gi', builtin.lsp_implementations, bufopts)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wl', function()
print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
vim.keymap.set('n', '<space>rn', '<cmd>Lspsaga rename<cr>', bufopts)
vim.keymap.set('n', '<space>ca', '<cmd>Lspsaga code_action<cr>', bufopts)
vim.keymap.set('n', '<space>cf', function() vim.lsp.buf.format { async = true } end, bufopts)
vim.keymap.set('n', 'gr', builtin.lsp_references, bufopts)

-- vim.keymap.set('n', 'gs', builtin.lsp_document_symbols, bufopts)
-- vim.keymap.set('n', 'gv', builtin.lsp_document_symbols({symbols = 'variable'}), bufopts)
-- vim.keymap.set('n', 'gf', builtin.lsp_document_symbols({symbols = {'function', 'method'}}), bufopts)
-- vim.keymap.set('n', 'gc', builtin.lsp_document_symbols({symbols = 'class'}), bufopts)
--
-- vim.keymap.set('n', 'gS', builtin.lsp_workspace_symbols, bufopts)
-- vim.keymap.set('n', 'gV', builtin.lsp_workspace_symbols({symbols = 'variable'}), bufopts)
-- vim.keymap.set('n', 'gF', builtin.lsp_workspace_symbols({symbols = {'function', 'method'}}), bufopts)
-- vim.keymap.set('n', 'gC', builtin.lsp_workspace_symbols({symbols = 'class'}), bufopts)
--
vim.keymap.set('n', 'gs', builtin.lsp_document_symbols, bufopts)
vim.keymap.set('n', 'gv', "<cmd>lua require('telescope.builtin').lsp_document_symbols({symbols = 'variable'})<cr>", bufopts)
vim.keymap.set('n', 'gf', "<cmd>lua require('telescope.builtin').lsp_document_symbols({symbols = {'function', 'method'}})<cr>", bufopts)
vim.keymap.set('n', 'go', "<cmd>lua require('telescope.builtin').lsp_document_symbols({symbols = {'class', 'struct'}})<cr>", bufopts)

vim.keymap.set('n', 'gS', builtin.lsp_dynamic_workspace_symbols, bufopts)
vim.keymap.set('n', 'gV', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols({symbols = 'variable'})<cr>", bufopts)
vim.keymap.set('n', 'gF', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols({symbols = {'function', 'method'}})<cr>", bufopts)
vim.keymap.set('n', 'gO', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols({symbols = {'class', 'struct'}})<cr>", bufopts)


-- Nvim-dap
local dap = require('dap')
vim.keymap.set('n', '<F5>', dap.continue, default_opts)
vim.keymap.set('n', '<F10>', dap.step_over, default_opts)
vim.keymap.set('n', '<F11>', dap.step_into, default_opts)
vim.keymap.set('n', '<F12>', dap.step_out, default_opts)
