local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Adds a file to harpoon
vim.keymap.set("n", "<leader>a", mark.add_file)
-- Toggles harpoon menu
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

-- Quick switch to the top four files in harpoon
vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

-- To remove a file from the list, press dd when hovering over file in harpoon menu
-- Can yank and put files to reorder them

