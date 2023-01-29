require("neoscroll").setup({
    performance_mode = true,
})

local t = {}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "100" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "100" } }
t["zz"] = { "zz", { "100" } }

require("neoscroll.config").set_mappings(t)
