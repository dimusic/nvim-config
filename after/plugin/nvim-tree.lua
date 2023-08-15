require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        adaptive_size = false,
        width = {
            min = 30,
            max = 50,
        },
    },
    renderer = {
        -- group_empty = true,
    },
    filters = {
        -- dotfiles = true,
    },

    git = {
        ignore = true,
    },

    filesystem_watchers = {
        ignore_dirs = {
            "target",
            "dist",
            "build",
            "node_modules",
        },
    },
})
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "File Tree Toggle" })
vim.keymap.set("n", "<leader>o", function()
    require("nvim-tree.api").tree.find_file({ open = true, focus = true })
end, { desc = "Reveal File" })

-- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
--
-- local neoTree = require("neo-tree")
--
-- -- File Tree
-- vim.keymap.set("n", "<leader>e", "<cmd>NeoTreeFocusToggle<cr>", { desc = "File Tree Toggle" })
-- vim.keymap.set("n", "<leader>o", function()
--     neoTree.reveal_current_file()
-- end, { desc = "Reveal File" })
--
-- require("neo-tree").setup({
--     -- enable_diagnostics = false,
--
--     window = {
--         width = 25,
--     },
--
--     default_component_configs = {
--         modified = {
--             -- symbol = "[+]",
--
--             highlight = "NeoTreeModified",
--         },
--
--         git_status = {
--             symbols = {
--                 -- Change type
--                 -- added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
--                 -- modified = "🌝", -- or "", but this is redundant info if you use git_status_colors on the name
--                 -- deleted = "✖", -- this can only be used in the git_status source
--                 -- renamed = "", -- this can only be used in the git_status source
--                 -- -- Status type
--                 -- untracked = "",
--                 -- ignored = "",
--                 -- unstaged = "",
--                 -- staged = "",
--                 -- conflict = "",
--             },
--         },
--     },
--
--     buffers = {
--         follow_current_file = false,
--     },
-- })
