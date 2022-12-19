--vim.opt.guicursor = ""

vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

-- vim.opt.clipboard = "unnamedplus"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/vim/undodir"
vim.opt.undofile = true

--vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 0

vim.opt.updatetime = 100

vim.opt.cursorline = true
vim.opt.colorcolumn = "120"

vim.g.mapleader = " "

vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.history = 100

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.everforest_background = "hard"
--vim.g.everforest_better_performance = 1
