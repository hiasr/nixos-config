local M = {}

local function configure_exts()
  require("nvim-dap-virtual-text").setup {}

  local dap, dapui = require "dap", require "dapui"
  dapui.setup {} -- use default
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

local function configure_debuggers()
  -- require("config.dap.lua").setup()
  require("dap-config.python").setup()
  -- require("config.dap.rust").setup()
  require("dap-config.go").setup()
end

function M.setup()
  configure_exts() -- Extensions
  configure_debuggers() -- Debugger
  -- require("dap-config.keymaps").setup() -- Keymaps
end

configure_debuggers()

return M
