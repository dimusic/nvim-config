local neoscroll = require("neoscroll")

neoscroll.setup({
    -- performance_mode = false,
    mappings = { "<C-u>", "<C-d>", "<C-f>", "<C-b>", "zz", "zt", "zb" },
})

local keymap = {
    ["<C-u>"] = function()
        neoscroll.ctrl_u({ duration = 100 })
    end,
    ["<C-d>"] = function()
        neoscroll.ctrl_d({ duration = 100 })
    end,
    -- ["zz"] = function()
    --     neoscroll.zz({ duration = 100 })
    -- end,
}
local modes = { "n", "v", "x" }
for key, func in pairs(keymap) do
    vim.keymap.set(modes, key, func)
end
