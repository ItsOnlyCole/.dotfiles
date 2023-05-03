-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

-- Telescope fuzzy finder
  use {
	'nvim-telescope/telescope.nvim', tag = '0.1.1',
	-- or                            , branch = '0.1.x',
	requires = { {'nvim-lua/plenary.nvim'} }
  }
-- Tokyo Night Color Scheme
  use({
	  'folke/tokyonight.nvim',
	  config = function()
		  -- Uncomment which one you want to use
		  --vim.cmd [[colorscheme tokyonight]]
		  vim.cmd [[colorscheme tokyonight-night]]
		  --vim.cmd [[colorscheme tokyonight-storm]]
		  --vim.cmd [[colorscheme tokyonight-day]]
		  --vim.cmd [[colorscheme tokyonight-moon]]
	  end
  })

-- Treesitter (Syntax Highlighting)
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

-- Harpoon (File quick switch)
  use('theprimeagen/harpoon')

-- Undo Tree
  use('mbbill/undotree')

-- Vim Fugitive (Git management)
  use('tpope/vim-fugitive')

-- LSP-Zero (Autocompletion and LSP)
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }
end)
