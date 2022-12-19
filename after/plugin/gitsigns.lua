vim.keymap.set("n", "<leader>e", "<cmd>NeoTreeFocusToggle<cr>", { desc = "File Tree Toggle" })

vim.keymap.set("n", "<leader>gj", function()
    require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })

vim.keymap.set("n", "<leader>gk", function()
    require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })

vim.keymap.set("n", "<leader>gl", function()
    require("gitsigns").blame_line()
end, { desc = "Blame line" })

vim.keymap.set("n", "<leader>gL", function()
    require("gitsigns").toggle_current_line_blame()
end, { desc = "Blame line" })

vim.keymap.set("n", "<leader>gp", function()
    require("gitsigns").preview_hunk()
end, { desc = "Preview git hunk" })

vim.keymap.set("n", "<leader>gh", function()
    require("gitsigns").reset_hunk()
end, { desc = "Reset git hunk" })

vim.keymap.set("n", "<leader>gr", function()
    require("gitsigns").reset_buffer()
end, { desc = "Reset git buffer" })

vim.keymap.set("n", "<leader>gd", function()
    require("gitsigns").diffthis()
end, { desc = "View git diff" })

require("gitsigns").setup({
    current_line_blame_opts = {
        virt_text_pos = "eol",
        delay = 100,
    },
})
