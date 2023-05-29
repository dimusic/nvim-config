local lsp = require("lsp-zero")

lsp.preset("lsp-compe")

local rust_lsp = lsp.build_options("rust-analyzer", {
    on_attach = function(_, bufnr)
        -- Hover actions
        vim.keymap.set("n", "<C-space>", require("rust-tools").hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        vim.keymap.set("n", "<space>ca", require("rust-tools").code_action_group.code_action_group, { buffer = bufnr })
        -- require("rust-tools").inlay_hints.enable()
    end,

    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
        },
    },
})

lsp.ensure_installed({
    "tsserver",
    "rust_analyzer",
})

local source_mapping = {
    -- cmp_tabnine = "🐒",
    cmp_tabnine = "🤖",
    copilot = "🤖",
    nvim_lsp_signature_help = "🐷",
    -- nvim_lsp = "λsp🐓",
    nvim_lsp = "🐓",
    vsnip = "⋗",
    buffer = "🍌",
    path = "📁",
}

lsp.configure("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

local cmp = require("cmp")
local has_words_before = function()
    if not unpack then
        unpack = table.unpack
    end

    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<C-]>", function()
        vim.lsp.buf.definition()
    end, { buffer = bufnr, remap = false, desc = "Go to Definition" })

    vim.keymap.set(
        "n",
        "<leader>]",
        ":vsp<cr> :lua vim.lsp.buf.definition()<cr>",
        { buffer = bufnr, remap = false, desc = "Go Definition (New Split)" }
    )
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, { buffer = bufnr, remap = false, desc = "Hover Definition" })

    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_next()
    end, { buffer = bufnr, remap = false, desc = "Next Diagnostic" })

    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_prev()
    end, { buffer = bufnr, remap = false, desc = "Prev Diagnostic" })

    vim.keymap.set("n", "<leader>ld", function()
        vim.diagnostic.open_float({
            border = "rounded",
            source = "always",
            -- prefix = "",
            scope = "line",
        })
    end, { buffer = bufnr, remap = false, desc = "Hover diagnostics" })

    vim.keymap.set("n", "<leader>lf", function()
        vim.lsp.buf.format()
    end, { buffer = bufnr, remap = false, desc = "Format" })

    vim.keymap.set("n", "<leader>la", function()
        vim.lsp.buf.code_action()
    end, { buffer = bufnr, remap = false, desc = "Code Action" })

    vim.keymap.set("n", "<leader>lR", function()
        vim.lsp.buf.references()
    end, { buffer = bufnr, remap = false, desc = "References" })

    vim.keymap.set("n", "<leader>lr", function()
        vim.lsp.buf.rename()
    end, { buffer = bufnr, remap = false, desc = "Rename" })

    vim.keymap.set("n", "<leader>lhe", function()
        require("rust-tools").inlay_hints.enable()
    end, { buffer = bufnr, remap = false, desc = "Enable Rust Tools Inlay Hints" })

    vim.keymap.set("n", "<leader>lhd", function()
        require("rust-tools").inlay_hints.disable()
    end, { buffer = bufnr, remap = false, desc = "Disable Rust Tools Inlay Hints" })

    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, { buffer = bufnr, remap = false, desc = "Signature Help" })
end)

-- lsp.skip_server_setup({ "clangd" })
lsp.skip_server_setup({ "rust_analyzer" })

lsp.setup()

-- require("clangd_extensions").setup({
--     server = {
--         cmd = { "clangd", "--offset-encoding=utf-16" },
--     },
-- })

require("rust-tools").setup({
    server = rust_lsp,
})

local cmp_config = lsp.defaults.cmp_config({
    sources = cmp.config.sources({
        { name = "copilot" },
        -- { name = "cmp_tabnine" },
        { name = "path" },
        { name = "nvim_lsp" },
    }, {
        { name = "buffer", keyword_length = 2, max_item_count = 10 },
    }),

    -- tabnine
    -- sorting = {
    --     priority_weight = 2,
    --     comparators = {
    --         require("cmp_tabnine.compare"),
    --         require("cmp.config.compare").offset,
    --         require("cmp.config.compare").exact,
    --         require("cmp.config.compare").score,
    --         require("cmp.config.compare").recently_used,
    --         require("cmp.config.compare").kind,
    --         require("cmp.config.compare").sort_text,
    --         require("cmp.config.compare").length,
    --         require("cmp.config.compare").order,
    --     },
    -- },

    -- copilot
    sorting = {
        priority_weight = 2,
        comparators = {
            require("copilot_cmp.comparators").prioritize,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    preselect = cmp.PreselectMode.None,
    window = {
        completion = cmp.config.window.bordered(),
    },
    formatting = {
        fields = { "menu", "abbr", "kind" },
        format = function(entry, vim_item)
            vim_item.kind = require("lspkind").symbolic(vim_item.kind, { mode = "symbol" })
            vim_item.menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
                local detail = (entry.completion_item.data or {}).detail
                vim_item.kind = ""
                if detail and detail:find(".*%%.*") then
                    vim_item.kind = vim_item.kind .. " " .. detail
                end

                if (entry.completion_item.data or {}).multiline then
                    vim_item.kind = vim_item.kind .. " " .. "[ML]"
                end
            end
            local maxwidth = 80
            vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
            return vim_item
        end,
    },

    mapping = lsp.defaults.cmp_mappings({
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end),
    }),
})

cmp.setup(cmp_config)

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = true,
})

-- vim.cmd([[
--     autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
-- ]])

require("fidget").setup({})
