require("neoscroll").setup({
    performance_mode = false,
    mappings = { "<C-u>", "<C-d>", "<C-f>", "<C-b>", "zz", "zt", "zb" },
})

local t = {}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "100" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "100" } }
t["zz"] = { "zz", { "100" } }

require("neoscroll.config").set_mappings(t)
