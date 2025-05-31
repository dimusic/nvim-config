local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },

    { "smartpde/telescope-recent-files" },

    -- Colorschemes
    {
        "neanias/everforest-nvim",
        lazy = true,
        config = function()
            require("everforest").setup({
                transparent_background_level = 1,
            })
        end,
    },

    { "muchzill4/doubletrouble", lazy = true },

    { "embark-theme/vim", name = "embark", lazy = true },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    { "nvim-treesitter/playground", lazy = true },
    { "nvim-treesitter/nvim-treesitter-context" },
    { "theprimeagen/harpoon" },
    {
        "mbbill/undotree",
        lazy = true,
        keys = {
            { "<Leader>u", ":UndotreeToggle<CR>", desc = "Undotree" },
        },
    },

    -- {
    --     "mrcjkb/rustaceanvim",
    --     version = "^5", -- Recommended
    --     lazy = false,
    -- },

    {
        { "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        {
            "saghen/blink.cmp",
            -- optional: provides snippets for the snippet source
            dependencies = "rafamadriz/friendly-snippets",

            -- use a release tag to download pre-built binaries
            version = "*",
            -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
            -- build = 'cargo build --release',
            -- If you use nix, you can build from source using latest nightly rust with:
            -- build = 'nix run .#build-plugin',

            ---@module 'blink.cmp'
            ---@type blink.cmp.Config
            opts = {
                -- 'default' for mappings similar to built-in completion
                -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
                -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
                -- See the full "keymap" documentation for information on defining your own keymap.
                keymap = {
                    preset = "super-tab",

                    ["<S-Tab>"] = {
                        function(cmp)
                            -- cmp.abort()

                            local copilot_keys = vim.fn["copilot#Accept"]()
                            if copilot_keys ~= "" and type(copilot_keys) == "string" then
                                vim.api.nvim_feedkeys(copilot_keys, "i", true)
                            end
                        end,
                    },
                },

                appearance = {
                    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                    -- Useful for when your theme doesn't support blink.cmp
                    -- Will be removed in a future release
                    use_nvim_cmp_as_default = true,
                    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                    -- Adjusts spacing to ensure icons are aligned
                    nerd_font_variant = "mono",
                },

                -- Default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`
                sources = {
                    default = { "lsp", "path", "buffer", "snippets" },
                },

                completion = {
                    -- 'prefix' will fuzzy match on the text before the cursor
                    -- 'full' will fuzzy match on the text before *and* after the cursor
                    -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
                    -- keyword = { range = "full" },

                    -- @alias blink.cmp.WindowBorder 'single' | 'double' | 'rounded' | 'solid' | 'shadow' | 'padded' | 'none' | blink.cmp.WindowBorderChar[]
                    menu = { border = "rounded" },

                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 100,
                        window = {
                            border = "rounded",
                        },
                    },
                    ghost_text = { enabled = false },
                },

                signature = { enabled = true, window = { border = "rounded" } },
            },
            opts_extend = { "sources.default" },
        },
    },

    -- {
    --     "TabbyML/vim-tabby",
    --     lazy = false,
    --     init = function()
    --         vim.g.tabby_agent_start_command = { "npx", "tabby-agent", "--stdio" }
    --         vim.g.tabby_inline_completion_trigger = "auto"
    --     end,
    -- },

    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
    },

    { "onsails/lspkind.nvim" },

    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({})
        end,
    },

    {
        "anuvyklack/windows.nvim",
        dependencies = "anuvyklack/middleclass",
        config = function()
            require("windows").setup()
        end,
    },

    { "windwp/nvim-autopairs" },

    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },

    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        -- tag = "nightly", -- optional, updated every week. (see issue #1193)
    },

    {
        "j-hui/fidget.nvim",
        tag = "v1.6.1",
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = true,
    },

    { "akinsho/bufferline.nvim", requires = "nvim-tree/nvim-web-devicons" },
    { "feline-nvim/feline.nvim" },

    -- copilot
    -- {
    --     "zbirenbaum/copilot.lua",
    --     config = function()
    --         require("copilot").setup({
    --             panel = { enabled = false },
    --             suggestion = { enabled = false },
    --         })
    --     end,
    -- },
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     -- after = { "copilot.lua" },
    --     config = function()
    --         require("copilot_cmp").setup()
    --     end,
    -- },

    { "github/copilot.vim" },

    { "vim-scripts/zoom.vim" },

    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
    },

    { "lewis6991/gitsigns.nvim" },

    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },

    { "mrjones2014/smart-splits.nvim" },
    { "folke/zen-mode.nvim" },

    { "RRethy/vim-illuminate" },

    {
        "Shatur/neovim-session-manager",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },

    {
        "Eandrju/cellular-automaton.nvim",
        lazy = true,
        keys = {
            { "<leader>lm", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it rain" },
        },
    },

    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    {
        "stevearc/aerial.nvim",
        lazy = true,
        config = function()
            require("aerial").setup()
        end,
    },

    { "karb94/neoscroll.nvim" },

    { "christoomey/vim-tmux-navigator" },

    { "wakatime/vim-wakatime" },

    { "renerocksai/calendar-vim" },

    {
        "renerocksai/telekasten.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        lazy = true,
        config = function()
            require("telekasten").setup({
                home = vim.fn.expand("~/SynologyDrive/notes-telekasten"), -- Put the name of your notes directory here
            })
        end,
    },

    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
    },

    { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },
})
