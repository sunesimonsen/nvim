vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Hooks for plugins that need post-install/update actions
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind

    if kind == 'install' or kind == 'update' then
      if name == 'nvim-treesitter' then
        if not ev.data.active then
          vim.cmd.packadd 'nvim-treesitter'
        end
        vim.cmd 'TSUpdate'
      elseif name == 'marksman' then
        vim.system({ 'make' }, { cwd = vim.fn.stdpath 'data' .. '/site/pack/core/opt/marksman' }):wait()
      end
    end
  end,
})

vim.pack.add {
  -- Everything from mini.nvim
  { src = 'https://github.com/nvim-mini/mini.nvim', version = 'v0.17.0' },

  -- Projects
  { src = 'https://github.com/DrKJeff16/project.nvim', version = 'v2.0.0-1' },

  -- LSP
  { src = 'https://github.com/artempyanykh/marksman', version = '2026-02-08' },
  { src = 'https://github.com/neovim/nvim-lspconfig', version = 'v2.7.0' },
  { src = 'https://github.com/mason-org/mason.nvim', version = 'v2.2.1' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim', version = 'v2.1.0' },
  { src = 'https://github.com/j-hui/fidget.nvim', version = 'v1.6.1' },

  -- Tree sitter
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = '4916d6592ede8c07973490d9322f187e07dfefac' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = '93d60a475f0b08a8eceb99255863977d3a25f310' },

  -- Formatting
  { src = 'https://github.com/tpope/vim-sleuth', version = 'v2.0' },
  { src = 'https://github.com/stevearc/conform.nvim', version = 'v9.1.0' },

  -- Editing
  'https://github.com/sunesimonsen/killring.nvim',
  { src = 'https://github.com/poljar/typos.nvim', version = '9315badebfe72efd8020ae7b1d2f176903ea6794' },

  -- Notes
  'https://github.com/sunesimonsen/notes.nvim',

  -- AI
  { src = 'https://github.com/robitx/gp.nvim', version = 'v3.9.0' },
}
