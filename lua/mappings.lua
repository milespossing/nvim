vim.keymap.set('n', '<C-t>', '<cmd>NvimTreeToggle<cr>')

-- What we would _really_ like here is to be able to specify different areas
-- in some kind of array in the way they did it at NvChad. For now we'll stick
-- to vanilla--but it is very tempting to try to build a help menu for this
-- particular area

-- Telescope
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})

-- NvimTree
vim.keymap.set('n', '<C-n>', '<cmd> NvimTreeToggle <CR>', {})

-- leap
vim.keymap.set('n', '<leader><leader>w', '<Plug>(leap-forward-to)', {})
vim.keymap.set('n', '<leader><leader>b', '<Plug>(leap-backward-to)', {})
