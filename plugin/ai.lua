local paths = require 'custom.paths'

local function open_prompt()
  local git_path = paths.get_git_path()
  local prompt_dir = vim.fs.joinpath(git_path, '.pi')
  local prompt_path = vim.fs.joinpath(prompt_dir, 'prompt.md')

  if vim.fn.isdirectory(prompt_dir) == 0 then
    vim.fn.mkdir(prompt_dir, 'p')
  end

  if vim.fn.filereadable(prompt_path) == 0 then
    vim.fn.writefile({}, prompt_path)
  end

  vim.cmd.edit(vim.fn.fnameescape(prompt_path))
end

vim.keymap.set('n', '<leader>ap', open_prompt, { desc = 'Open AI prompt' })
