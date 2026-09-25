local paths = require 'custom.paths'

local function prompt_path()
  local git_path = paths.get_git_path()
  local prompt_dir = vim.fs.joinpath(git_path, '.pi')
  local path = vim.fs.joinpath(prompt_dir, 'prompt.md')

  if vim.fn.isdirectory(prompt_dir) == 0 then
    vim.fn.mkdir(prompt_dir, 'p')
  end

  if vim.fn.filereadable(path) == 0 then
    vim.fn.writefile({}, path)
  end

  return git_path, path
end

local function open_prompt()
  local _, path = prompt_path()
  vim.cmd.edit(vim.fn.fnameescape(path))
end

vim.keymap.set({ 'n', 'v' }, '<leader>ae', open_prompt, { desc = 'Open project prompt' })

local function append_to_prompt(path, entry)
  local prompt_buf = vim.fn.bufnr(path)

  if prompt_buf ~= -1 and vim.api.nvim_buf_is_loaded(prompt_buf) and vim.bo[prompt_buf].modified then
    local line_count = vim.api.nvim_buf_line_count(prompt_buf)
    local buffer_lines = vim.api.nvim_buf_get_lines(prompt_buf, 0, line_count, false)

    if line_count == 1 and buffer_lines[1] == '' then
      vim.api.nvim_buf_set_lines(prompt_buf, 0, 1, false, { entry })
    else
      vim.api.nvim_buf_set_lines(prompt_buf, line_count, line_count, false, { entry })
    end
  else
    local lines = vim.fn.readfile(path)
    table.insert(lines, entry)
    vim.fn.writefile(lines, path)
  end
end

local function append_file_path()
  local git_path, path = prompt_path()
  local file_path = vim.api.nvim_buf_get_name(0)

  if file_path == '' then
    vim.notify('Current buffer has no file path', vim.log.levels.WARN)
    return
  end

  local entry = vim.fs.relpath(git_path, file_path)

  if not entry then
    vim.notify('Current file is outside the git project', vim.log.levels.WARN)
    return
  end

  local mode = vim.fn.mode()

  if mode == 'v' or mode == 'V' or mode == '\22' then
    local start_line = vim.fn.line "'<"
    local end_line = vim.fn.line "'>"
    entry = string.format('%s:%d-%d', entry, math.min(start_line, end_line), math.max(start_line, end_line))
  end

  vim.ui.input({ prompt = 'AI prompt: ' }, function(input)
    if input == nil then
      return
    end

    if input ~= '' then
      entry = string.format('%s %s', input, entry)
    end

    append_to_prompt(path, entry)
  end)
end

vim.keymap.set({ 'n', 'v' }, '<leader>ap', append_file_path, { desc = 'Prompt for change' })
