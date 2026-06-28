require('mini.visits').setup()
require('mini.files').setup()

vim.keymap.set('n', '<leader>fs', ':w<CR>', { desc = 'Save file' })

vim.keymap.set('n', '<leader>dd', function()
  local MiniFiles = require 'mini.files'
  local _ = MiniFiles.close() or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  vim.schedule(function()
    MiniFiles.reveal_cwd()
  end)
end, { desc = 'Open current directory' })

vim.keymap.set('n', '<leader>pd', ':lua MiniFiles.open()<cr>', { desc = 'Open project directory' })

local function get_git_path()
  return vim.fn.trim(vim.fn.system 'git rev-parse --show-toplevel')
end

vim.keymap.set('n', '<leader>dg', function()
  local MiniFiles = require 'mini.files'
  local ok, path = pcall(get_git_path)
  if ok then
    MiniFiles.open(path)
  else
    MiniFiles.open()
  end
end, { desc = 'Open git directory' })

vim.keymap.set('n', '<leader>fn', ':e %:p:h/', { desc = 'New file' })
