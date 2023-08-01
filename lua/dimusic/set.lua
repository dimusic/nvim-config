--vim.opt.guicursor = ""

vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

-- vim.opt.clipboard = "unnamedplus"

-- vim.opt.hidden = false
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
-- vim.opt.undodir = os.getenv("HOME") .. "/vim/undodir"
-- vim.opt.undofile = true
vim.opt.undolevels = 100

--vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1

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

vim.g.rustfmt_autosave = 1

local is_wsl = (function()
    local output = vim.fn.systemlist("uname -r")
    return not not string.find(output[1] or "", "WSL")
end)()

if is_wsl then
    vim.cmd([[
    let g:clipboard = {
      \ 'name': 'WslClipboard',
      \ 'copy': {
      \   '+': '/mnt/c/Windows/System32/clip.exe',
      \   '*': '/mnt/c/Windows/System32/clip.exe',
      \ },
      \   'paste': {
      \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      \   },
      \ 'cache_enabled': 0
      \ }
    ]])
end

vim.cmd([[
" trigger `autoread` when files changes on disk
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost *
\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
]])

vim.cmd([[
autocmd BufNewFile,BufRead *.wgsl set filetype=wgsl
]])

vim.g.copilot_assume_mapped = true
