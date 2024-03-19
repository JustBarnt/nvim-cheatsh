local config = require("nvim-cheatsh.config")

local M = {}

---@param str string String to escape
local function strip_ansi(str)
  return str:gsub("\x1b%[[0-9;]*m", "")
end

function M.fetch_cheatsheet(query, silent, callback)
  local url = config.options.cheatsh_url

  if not silent then
    vim.notify("Fetching cheatsheet for " .. query, vim.log.levels.INFO, { title = "Cheatsh" })
  end

  vim.system({ "curl", "-s", "-S", url .. query }, { text = true }, function(out)
    local lines = {}
    if out.code ~= 0 then
      vim.notify(out.stderr, vim.log.levels.ERROR)
    else
      local out_str, _ = strip_ansi(out.stdout)
      for line in out_str:gmatch("[^\n]+") do
        table.insert(lines, line)
      end
      vim.schedule(function()
        callback(lines)
      end)
    end
  end)
end

function M.fetch_list(callback)
  local url = config.options.cheatsh_url
  local lines = {}
  url = url .. ":list"

  vim.system({ "curl", "-s", "-S", url }, { text = true }, function(cmd_res)
    if cmd_res.code ~= 0 then
      vim.notify(cmd_res.stderr, vim.log.levels.ERROR)
    else
      local res_str, _ = strip_ansi(cmd_res.stdout)

      for line in res_str:gmatch("[^\n]+") do
        table.insert(lines, line)
      end

      vim.schedule(function()
        callback(lines)
      end)
    end
  end)
end

return M
