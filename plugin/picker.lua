require('project').setup {
  detection_methods = { 'pattern' },
  patterns = { '.git', 'Makefile', 'package.json', '.project' },
  scope_chdir = 'tab',
}

local MiniPick = require 'mini.pick'
MiniPick.setup()
require('mini.extra').setup()

require('mini.visits').setup()

local paths = require 'custom.paths'

vim.keymap.set('n', '<leader>*', ":Pick grep pattern='<cword>'<cr>", { desc = 'Search current word' })
vim.keymap.set('n', "<leader>'", ':Pick resume<cr>', { desc = 'Search resume' })

vim.keymap.set('n', '<leader>bb', ':Pick buffers<cr>', { desc = 'Find existing buffers' })
vim.keymap.set('n', '<leader>fr', ':Pick visit_paths recency_weight=1<cr>', { desc = 'Search recent files' })
vim.keymap.set('n', '<leader>fR', ':Pick visit_paths cwd="" recency_weight=1<cr>', { desc = 'Search recent files (globally)' })

vim.keymap.set('n', '<leader>es', ':Pick diagnostic<cr>', { desc = 'Search diagnostics' })

vim.keymap.set('n', '<leader>sf', ':Pick grep_live<cr>', { desc = 'Search with grep' })
vim.keymap.set('n', '<leader>sg', function()
  local path = paths.get_git_path()
  MiniPick.builtin.grep_live(nil, { source = { cwd = path } })
end, { desc = 'Search with grep (from git dir)' })

vim.keymap.set('n', '<leader>sd', function()
  MiniPick.builtin.grep_live(nil, { source = { cwd = vim.fn.expand '%:p:h' } })
end, { desc = 'Search with grep (dir)' })

vim.keymap.set('n', '<leader>sc', ':Pick commands<cr>', { desc = 'Search commands' })

vim.keymap.set('n', '<leader>qs', ":Pick list scope='quickfix'<cr>", { desc = 'Search quickfixes' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>ss', ":Pick buf_lines scope='current'<cr>", { desc = 'Search buffer' })

vim.keymap.set('n', '<leader>ff', ':Pick files<cr>', { desc = 'Search project files' })

vim.keymap.set('n', '<leader>fg', function()
  local path = paths.get_git_path()
  MiniPick.builtin.files(nil, { source = { cwd = path } })
end, { desc = 'Find files from Git dir' })

vim.keymap.set('n', '<leader>sg', function()
  local path = paths.get_git_path()
  MiniPick.builtin.grep_live(nil, { source = { cwd = path } })
end, { desc = 'Search with grep (from git dir)' })

vim.keymap.set('n', '<leader>fd', ':Pick explorer cwd="%:p:h"<cr>', { desc = 'Browse' })

vim.keymap.set('n', '<leader>pd', ':Pick explorer<cr>', { desc = 'Browse project dir' })

MiniPick.registry.project = function()
  local projects = require('project').get_recent_projects()

  local sorted_projects = {}

  for _, project in pairs(projects) do
    if not string.find(project['path'], '/node_modules/') then
      table.insert(sorted_projects, project)
    end
  end

  table.sort(sorted_projects, function(a, b)
    return string.lower(a['name']) < string.lower(b['name'])
  end)

  vim.ui.select(sorted_projects, {
    prompt = 'Project:',
    format_item = function(project)
      return project['name']
    end,
  }, function(project)
    if project then
      MiniPick.builtin.files(nil, { source = { cwd = project['path'] } })
    else
      vim.notify('No project selected', vim.log.levels.WARN)
    end
  end)
end

vim.keymap.set('n', '<leader>pp', ':Pick project<cr>', { desc = 'Search projects' })

vim.keymap.set('n', '<leader>tp', function()
  vim.cmd 'tabnew %'
  MiniPick.registry.project()
end, { desc = 'Tab search projects' })

vim.keymap.set('n', '<leader>sS', ':Pick buf_lines<cr>', { desc = 'Search buffers' })

vim.keymap.set('n', '<leader>vf', function()
  MiniPick.builtin.files(nil, { source = { cwd = vim.fn.stdpath 'config' } })
end, { desc = 'Search Neovim files' })

vim.keymap.set('n', '<leader>vs', function()
  MiniPick.builtin.grep_live(nil, { source = { cwd = vim.fn.stdpath 'config' } })
end, { desc = 'Search Neovim files' })

vim.keymap.set('n', '<leader>vc', ':Pick colorschemes<cr>', { desc = 'Colorschemes' })

vim.keymap.set('n', '<leader>gb', ':Pick git_branches<cr>', { desc = 'Branches' })
vim.keymap.set('n', '<leader>gl', ":Pick git_commits path='%'<cr>", { desc = 'File commits' })
vim.keymap.set('n', '<leader>gL', ':Pick git_commits<cr>', { desc = 'Commits' })
vim.keymap.set('n', '<leader>gh', ':Pick git_hunks<cr>', { desc = 'Unstaged' })
--vim.keymap.set('n', '<leader>gf', ':Pick git_files scope="modified"<cr>', { desc = 'Unstaged' })

vim.keymap.set('n', '<leader>yr', ':Pick registers<cr>', { desc = 'Yank register' })

MiniPick.registry.git_status = function()
  local output = vim.fn.system { 'git', 'status', '--porcelain' }
  local items = {}
  for _, line in ipairs(vim.split(output, '\n')) do
    if line ~= '' then
      table.insert(items, line)
    end
  end

  local get_path = function(item)
    local path = item:sub(4)
    -- Renames are reported as "old -> new"; follow the new path
    return path:match '^(.*) -> ' or path
  end

  local choose = function(item)
    if item == nil then
      return
    end
    -- Schedule so the edit happens after the picker window is closed;
    -- otherwise the file is opened in (and lost with) the picker float
    vim.schedule(function()
      vim.cmd('edit ' .. vim.fn.fnameescape(get_path(item)))
    end)
  end

  local preview = function(buf_id, item)
    if item == nil then
      return
    end

    local path = get_path(item)
    local lines = {}
    if not item:match '^%?%?' then
      -- Show both staged and unstaged changes against HEAD
      lines = vim.fn.systemlist { 'git', 'diff', 'HEAD', '--', path }
    end

    -- Untracked files (and tracked files without changes) have no diff;
    -- fall back to showing the file content
    if vim.tbl_isempty(lines) then
      local ok, contents = pcall(vim.fn.readfile, path)
      lines = ok and contents or { 'Could not read ' .. path }
      vim.bo[buf_id].filetype = vim.filetype.match { filename = path } or 'text'
    else
      vim.bo[buf_id].filetype = 'diff'
    end

    vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
  end

  MiniPick.start {
    source = { items = items, name = 'Git status', choose = choose, preview = preview },
  }
end

vim.keymap.set('n', '<leader>gs', ':Pick git_status<cr>', { desc = 'Git status' })
