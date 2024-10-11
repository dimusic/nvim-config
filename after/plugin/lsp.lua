local lsp_zero = require("lsp-zero")
local nvim_lsp = require("lspconfig")

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

local lsp_attach = function(client, bufnr)
    if nvim_lsp.util.root_pattern("deno.json", "deno.jsonc", "import_map.json")(vim.fn.getcwd()) then
        if client.name == "ts_ls" then
            client.stop()
            return
        end
    end

    lsp_zero.default_keymaps({ buffer = bufnr })
    -- local opts = { buffer = bufnr, remap = false }

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

    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, { buffer = bufnr, remap = false, desc = "Signature Help" })
end

lsp_zero.extend_lspconfig({
    sign_text = true,
    lsp_attach = lsp_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

require("mason").setup({
    -- PATH = "append",
})
require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,

        ["rust_analyzer"] = lsp_zero.noop,

        ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
        end,

        ["ts_ls"] = function()
            require("lspconfig").ts_ls.setup({
                root_dir = nvim_lsp.util.root_pattern("package.json"),
                single_file_support = false,
            })
        end,

        ["denols"] = function()
            require("lspconfig").denols.setup({
                root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc", "import_map.json"),
            })
        end,

        ["angularls"] = function()
            require("lspconfig").angularls.setup({
                on_init = function(client)
                    client.server_capabilities.renameProvider = false
                end,
            })
        end,
    },
})

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },

    sources = cmp.config.sources({
        -- { name = "copilot", priority_weight = 8 },
        -- { name = "cmp_tabnine" },
        { name = "nvim_lsp", priority_weight = 8 },
    }, {
        { name = "buffer", keyword_length = 2, max_item_count = 10, priority_weight = 7 },
        { name = "path", priority_weight = 4 },
    }),

    sorting = {
        priority_weight = 2,
        comparators = {
            -- require("copilot_cmp.comparators").prioritize,

            cmp.config.compare.exact,
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,
            cmp.config.compare.score,
            cmp.config.compare.sort_text,
            cmp.config.compare.offset,
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

    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
        }),

        ["<Tab>"] = vim.schedule_wrap(function(fallback)
            --cmp.mapping.abort()

            if cmp.visible() then
                cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                })()
            else
                fallback()
            end
        end),

        ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
            cmp.mapping.abort()

            local copilot_keys = vim.fn["copilot#Accept"]()
            if copilot_keys ~= "" and type(copilot_keys) == "string" then
                vim.api.nvim_feedkeys(copilot_keys, "i", true)
            else
                fallback()
            end
        end),

        ["<C-e>"] = cmp.mapping.complete(),
    }),
})

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

-- Rustaceanvim setup
vim.g.rustaceanvim = {
    tools = {},

    server = {
        -- on_attach = lsp_attach,

        capabilities = lsp_zero.get_capabilities(),

        default_settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
}
