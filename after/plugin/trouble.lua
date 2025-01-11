vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>xw",
    "<cmd>Trouble diagnostics toggle focus=true<cr>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>xd",
    "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp toggle focus=true<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<C-]>",
    "<cmd>Trouble lsp_definitions toggle focus=true<cr>",
    { noremap = true, silent = true, desc = "Trouble lsp_definitions toggle" }
)

require("trouble").setup()
