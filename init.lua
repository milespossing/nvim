vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require('plugins')

vim.g.mapleader = ','

require("nvim-tree").setup()

require('general')
require('settings')
require('mappings')
