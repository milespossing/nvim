-- Using lazy vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- TODO: Use key mappings for lazy.nvim
require('lazy').setup({
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  { 'nyoom-engineering/oxocarbon.nvim' },
  { 'kdheepak/lazygit.nvim' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp', dependencies = 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-path', dependencies = 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer', dependencies = 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-cmdline', dependencies = 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-vsnip' },
  { 'hrsh7th/vim-vsnip' },
  { 'hrsh7th/nvim-cmp' },
  { 'L3MON4D3/LuaSnip' },
  { 'voldikss/vim-floaterm' },
  { 'onsails/lspkind.nvim' },
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  {
    'tzachar/cmp-tabnine',
    build = './install.sh',
    dependencies = 'hrsh7th/nvim-cmp'
  },
  {
      'goolord/alpha-nvim',
      config = function()
	      require'config.alpha'.config()
      end
  },
  { 'ggandor/leap.nvim' },
  { 'epwalsh/obsidian.nvim' },
})



require("mason").setup()

require("plugins.cmp")
require("plugins.tabnine")

require('obsidian').setup({
    dir = "~/obsidian/WorkVault",
    completion = {
        nvim_cmp = true,
    }
})
