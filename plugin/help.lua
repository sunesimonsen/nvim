local miniclue = require 'mini.clue'
miniclue.setup {
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    { mode = 'n', keys = '<Leader>m' },
    { mode = 'x', keys = '<Leader>m' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },

    -- `[` key
    { mode = 'n', keys = '[' },
    { mode = 'x', keys = '[' },

    -- `]` key
    { mode = 'n', keys = ']' },
    { mode = 'x', keys = ']' },

    -- `g` key
    { mode = 'n', keys = 's' },
    { mode = 'x', keys = 's' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),

    { keys = '<leader>a', mode = 'n', desc = '+AI' },
    { keys = '<leader>ac', mode = 'v', desc = '+Chat' },
    { keys = '<leader>b', mode = 'n', desc = '+Buffers' },
    { keys = '<Leader>b', mode = 'n', desc = '+Buffers' },
    { keys = '<leader>c', mode = 'n', desc = '+Code' },
    { keys = '<leader>d', mode = 'n', desc = '+Directories' },
    { keys = '<leader>e', mode = 'n', desc = '+Errors' },
    { keys = '<leader>f', mode = 'n', desc = '+Files' },
    { keys = '<leader>g', mode = 'n', desc = '+Git' },
    { keys = '<leader>gf', mode = 'n', desc = '+Files' },
    { keys = '<leader>h', mode = 'n', desc = '+Help' },
    { keys = '<leader>j', mode = 'n', desc = '+Jump' },
    { keys = '<leader>m', mode = 'n', desc = '+Move' },
    { keys = '<Leader>mh', mode = 'n', postkeys = '<Leader>m' },
    { keys = '<Leader>mh', mode = 'x', postkeys = '<Leader>m' },
    { keys = '<Leader>mj', mode = 'n', postkeys = '<Leader>m' },
    { keys = '<Leader>mj', mode = 'x', postkeys = '<Leader>m' },
    { keys = '<Leader>mk', mode = 'n', postkeys = '<Leader>m' },
    { keys = '<Leader>mk', mode = 'x', postkeys = '<Leader>m' },
    { keys = '<Leader>ml', mode = 'n', postkeys = '<Leader>m' },
    { keys = '<Leader>ml', mode = 'x', postkeys = '<Leader>m' },
    { keys = '<leader>n', mode = 'n', desc = '+Notes' },
    { keys = '<leader>o', mode = 'n', desc = '+Open' },
    { keys = '<leader>p', mode = 'n', desc = '+Projects' },
    { keys = '<leader>q', mode = 'n', desc = '+Quickfix' },
    { keys = '<leader>r', mode = 'n', desc = '+Run' },
    { keys = '<leader>s', mode = 'n', desc = '+Search' },
    { keys = '<leader>t', mode = 'n', desc = '+Tabs' },
    { keys = '<leader>tg', mode = 'n', desc = '+Goto' },
    { keys = '<leader>v', mode = 'n', desc = '+Vim' },
    { keys = '<leader>vo', mode = 'n', desc = '+Open' },
    { keys = '<leader>w', mode = 'n', desc = '+Windows' },
    { keys = '<leader>x', mode = 'n', desc = '+Execute' },
    { keys = '<leader>y', mode = 'n', desc = '+Yank' },
    { keys = '<leader>yp', mode = 'n', desc = '+Path' },
  },
}

vim.keymap.set('n', '<leader>hh', ':Pick help<cr>', { desc = 'Search help' })
vim.keymap.set('n', '<leader>hk', ':Pick keymaps<cr>', { desc = 'Search keymaps' })
