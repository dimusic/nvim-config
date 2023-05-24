vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>xw",
    "<cmd>TroubleToggle workspace_diagnostics<cr>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>xd",
    "<cmd>TroubleToggle document_diagnostics<cr>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { noremap = true, silent = true })

require("trouble").setup()
