local MiniGit = require 'mini.git'
local MiniDiff = require 'mini.diff'

MiniDiff.setup()
MiniGit.setup()

vim.keymap.set('n', '<leader>go', MiniDiff.toggle_overlay, { desc = 'Toggle diff overlay' })
vim.keymap.set('n', '<leader>ga', ':Git add %<cr>', { desc = 'Git add file' })
vim.keymap.set('n', '<leader>gc', ':Git commit<cr>', { desc = 'Git commit' })
vim.keymap.set('n', '<leader>gp', ':Git log -p -n 50 %<cr>', { desc = 'Git file patches' })
vim.keymap.set('n', '<leader>gP', ':Git log -p -n 50<cr>', { desc = 'Git patches' })
vim.keymap.set('n', '<leader>gx', ':Git ', { desc = 'Git command' })
vim.keymap.set({ 'n', 'v' }, 'gs', MiniGit.show_at_cursor, { desc = 'Git show at cursor' })
