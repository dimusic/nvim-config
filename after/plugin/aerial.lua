vim.keymap.set("n", "<leader>lS", function()
    require("aerial").toggle()
end, { desc = "Aerial toggle" })
