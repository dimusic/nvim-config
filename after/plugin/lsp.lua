local lsp = require("lsp-zero")

lsp.preset("recommended")

local rust_lsp = lsp.build_options("rust_analyzer", {})

lsp.ensure_installed({
    "tsserver",
    "sumneko_lua",
    "rust_analyzer",
})

local source_mapping = {
    -- cmp_tabnine = "🐒",
    cmp_tabnine = "🤖",
    copilot = "🐔",
    nvim_lsp_signature_help = "🐷",
    -- nvim_lsp = "λsp🐓",
    nvim_lsp = "🐓",
    vsnip = "⋗",
    buffer = "🍌",
    path = "📁",
}

lsp.configure("sumneko_lua", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

local cmp = require("cmp")

lsp.setup_nvim_cmp({
    sources = cmp.config.sources({
        { name = "cmp_tabnine" },
        { name = "path" },
        { name = "nvim_lsp", keyword_length = 2, max_item_count = 20 },
    }, {
        { name = "buffer", keyword_length = 3, max_item_count = 3 },
    }),

    completion = {
        completeopt = "menu,menuone,noinsert,noselect",
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
    --mapping = cmp_mappings
})

-- vim.cmd([[
--     autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
-- ]])

lsp.on_attach(function(client, bufnr)
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

    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
    end, { buffer = bufnr, remap = false, desc = "Next Diagnostic" })

    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
    end, { buffer = bufnr, remap = false, desc = "Prev Diagnostic" })

    vim.keymap.set("n", "<leader>ld", function()
        vim.diagnostic.open_float()
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

    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, { buffer = bufnr, remap = false, desc = "Signature Help" })
end)

require("rust-tools").setup({
    server = rust_lsp,
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = false,
    float = true,
})

require("fidget").setup({})
