require("toggleterm").setup()

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    direction = "float",
    float_opts = {
        border = "double",
    },
    hidden = true,
})
local lazygit_term = nil

vim.keymap.set("n", "<leader>gg", function()
    lazygit:toggle()

    -- if not lazygit_term then
    --     lazygit_term = require("toggleterm.terminal").Terminal:new("lazygit")
    -- else
    --     lazygit_term:toggle()
    -- end
end, {
    desc = "ToggleTerm lazygit",
})

vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", {
    desc = "ToggleTerm lazygit",
})
