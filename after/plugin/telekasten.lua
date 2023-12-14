require("telekasten").setup({
    home = vim.fn.expand("~/notes-telekasten"), -- Put the name of your notes directory here

    -- vim.keymap.set("n", "<leader>n", function()
    --     require("telekasten").panel()
    -- end, { desc = "Show Telekasten panel" }),

    vim.keymap.set("n", "<leader>np", function()
        require("telekasten").panel()
    end, { desc = "Show Telekasten panel" }),

    vim.keymap.set("n", "<leader>nn", function()
        require("telekasten").new_note()
    end, { desc = "New note" }),

    vim.keymap.set("n", "<leader>nc", function()
        require("telekasten").show_calendar()
    end, { desc = "Show calendar" }),

    vim.keymap.set("n", "<leader>nl", function()
        require("telekasten").insert_link()
    end, { desc = "Insert link" }),

    vim.keymap.set("n", "<leader>nf", function()
        require("telekasten").follow_link()
    end, { desc = "Follow link" }),

    vim.keymap.set("n", "<leader>nb", function()
        require("telekasten").show_backlinks()
    end, { desc = "Show backlinks" }),

    vim.keymap.set("n", "<leader>ns", function()
        require("telekasten").search_notes()
    end, { desc = "Search in notes" }),

    vim.keymap.set("n", "<leader>nm", function()
        require("telekasten").find_notes()
    end, { desc = "Find notes" }),
})
