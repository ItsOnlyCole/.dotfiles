-- Sets Relative Line Numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tab Settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.showtabline = 4

-- Word Wrap
vim.opt.wrap = false

-- highlights current line
vim.opt.cursorline = true

-- Removes nvim backups but gives undotree access to file change history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Changes how search highlighting works
vim.opt.hlsearch = false
vim.opt.incsearch = true

--misc options
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
