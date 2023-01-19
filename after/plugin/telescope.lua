require("telescope").setup({
    defaults = {
        path_display = { "truncate" },

        mappings = {
            i = {
                ["<C-n>"] = require("telescope.actions").cycle_history_next,
                ["<C-p>"] = require("telescope.actions").cycle_history_prev,
                ["<C-j>"] = require("telescope.actions").move_selection_next,
                ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
        },
    },

    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
})

require("telescope").load_extension("fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", function()
    builtin.find_files({
        prompt_prefix = "🔍 ",
    })
end, { desc = "Find files" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find files" })

vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search help" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "File history" })
vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fW", function()
    builtin.live_grep({
        prompt_prefix = "🤪 ",
        additional_args = function(args)
            return vim.list_extend(args, { "--hidden", "--no-ignore" })
        end,
    })
end, { desc = "Live grep (all files)" })
