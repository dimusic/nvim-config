require("session_manager").setup({
    autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
})

vim.keymap.set("n", "<leader>Ss", "<cmd>SessionManager! save_current_session<cr>", { desc = "Save session" })
vim.keymap.set(
    "n",
    "<leader>S.",
    "<cmd>SessionManager! load_current_dir_session<cr>",
    { desc = "Load current directory session" }
)
vim.keymap.set("n", "<leader>Sf", "<cmd>SessionManager! load_session<cr>", { desc = "Search session" })
vim.keymap.set("n", "<leader>Sl", "<cmd>SessionManager! load_last_session<cr>", { desc = "Load last session" })
