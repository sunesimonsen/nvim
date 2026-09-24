require('oil').setup()
require('mini.visits').setup()
local paths = require 'custom.paths'

vim.keymap.set('n', '<leader>fs', ':w<CR>', { desc = 'Save file' })

vim.keymap.set('n', '<leader>dd', ':Oil<cr>', { desc = 'Open project directory' })

vim.keymap.set('n', '<leader>dp', function()
  local path = paths.get_project_path()
  require('oil').open(path)
end, { desc = 'Open project directory' })

vim.keymap.set('n', '<leader>dg', function()
  local path = paths.get_git_path()
  require('oil').open(path)
end, { desc = 'Open git directory' })

vim.keymap.set('n', '<leader>fn', ':e %:p:h/', { desc = 'New file' })

vim.keymap.set({ 'n', 'v' }, '<leader>ypr', ':CopyFilePath<CR>', { desc = 'Copy relative file path to the clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>ypn', ':CopyFileName<CR>', { desc = 'Copy just the file name to the clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>ypa', ':CopyAbsoluteFilePath<CR>', { desc = 'Copy absolute file path to the clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>yph', ':CopyRelativeFilePathFromHome<CR>', { desc = 'Copy relative file path from $HOME to the clipboard' })
