local builtin = require('telescope.builtin')
-- Find files in all files
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
-- Find files within current git repo
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- Find files that contains {String}
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
