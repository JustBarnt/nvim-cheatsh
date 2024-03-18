local config = require("nvim-cheatsh.config")

local M = {}

---@param str string String to escape
local function strip_ansi(str)
  return str:gsub("\x1b%[[0-9;]*m", "")
end

function M.fetch_cheatsheet(query, silent, callback)
  local url = config.options.cheatsh_url
  local lines = {}

  if not silent then
    vim.notify("Fetching cheatsheet for " .. query, vim.log.levels.INFO, { title = "Cheatsh" })
  end

  local cmd_res = vim.system({ "curl", "-s", "-S", url .. query }, { text = true }):wait()

  if cmd_res.code ~= 0 then
    vim.notify(cmd_res.stderr, vim.log.levels.ERROR)
  else
    local res_str, _ = strip_ansi(cmd_res.stdout)

    for line in res_str:gmatch("[^\n]+") do
      table.insert(lines, line)
    end

    callback(lines)
  end
end

function M.fetch_list(callback)
  local url = config.options.cheatsh_url
  local lines = {}
  url = url .. ":list"

  local cmd_res = vim.system({ "curl", "-s", "-S", url }, { text = true }):wait()

  if cmd_res.code ~= 0 then
    vim.notify(cmd_res.stderr, vim.log.levels.ERROR)
  else
    local res_str, _ = strip_ansi(cmd_res.stdout)

    for line in res_str:gmatch("[^\n]+") do
      table.insert(lines, line)
    end

    callback(lines)
  end
end

return M
