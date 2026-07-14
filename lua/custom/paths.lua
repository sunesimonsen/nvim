local M = {}

M.get_project_path = function()
  return require('project').current_root()
end

local function find_git_root()
  return vim.fn.trim(vim.fn.system 'git rev-parse --show-toplevel')
end

M.get_git_path = function()
  local ok, path = pcall(find_git_root)

  if ok then
    return path
  else
    return M.get_project_path()
  end
end

return M
