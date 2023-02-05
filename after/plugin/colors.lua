function Colorize(color)
    color = color or "everforest"

    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#383738" })

    vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
    vim.api.nvim_set_hl(0, "StatusLineTermNC", { bg = "none" })

    vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsAddNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsChangeNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsAddInline", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsStagedAdd", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsTopdelete", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsUntracked", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsAddPreview", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsAddLnInline", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsStagedAddLn", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsStagedAddNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsStagedAddNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignifySignAdd", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignifySignChange", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignifySignDelete", { bg = "none" })

    vim.api.nvim_set_hl(0, "GitGutterAdd", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitGutterChange", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitGutterDelete", { bg = "none" })
    vim.api.nvim_set_hl(0, "GitGutterChangeDelete", { bg = "none" })

    vim.api.nvim_set_hl(0, "NormalFloat", { fg = "white", bg = "#1f2335" })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "white", bg = "#1f2335" })
end

vim.g.background = "dark"
vim.g.everforest_background = "hard"
vim.g.everforest_better_performance = 1

-- require("rose-pine").setup()

Colorize("seoul256")
-- Colorize()
