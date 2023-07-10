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
        'nvim-telescope/telescope.nvim',
        version = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },

    { "smartpde/telescope-recent-files" },

    -- Colorschemes
    {
        "neanias/everforest-nvim",
        config = function()
            require("everforest").setup({
                transparent_background_level = 1,
            })
        end
    },

    { "muchzill4/doubletrouble" },

    { "embark-theme/vim", name = "embark" },

    {
        "nvim-treesitter/nvim-treesitter",
        -- run = ":TSUpdate",
    },

    {"nvim-treesitter/playground"},
    {"nvim-treesitter/nvim-treesitter-context"},
    {"theprimeagen/harpoon"},
    {"mbbill/undotree"},

    {
        "simrat39/rust-tools.nvim",
        config = function()
            local rt = require("rust-tools")

            rt.setup({
                server = {
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                        -- Code action groups
                        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                    end,
                },
            })
        end,
    },

    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {"onsails/lspkind.nvim"},

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

    -- {{ "windwp/nvim-autopairs" }},

    {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup()
        end,
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    {"lukas-reineke/indent-blankline.nvim"},

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        -- tag = "nightly", -- optional, updated every week. (see issue #1193)
    },

    {
        "j-hui/fidget.nvim",
        version = "legacy",
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = true
    },

    -- {{ "akinsho/bufferline.nvim", requires = "nvim-tree/nvim-web-devicons" }},
    { "feline-nvim/feline.nvim" },

    -- copilot
    {
        "zbirenbaum/copilot.lua",
        config = function()
            require("copilot").setup({
                panel = { enabled = false },
                suggestion = { enabled = false },
            })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        -- after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    },

    {"vim-scripts/zoom.vim"},

    {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    },

    {"lewis6991/gitsigns.nvim"},

    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },

    {"mrjones2014/smart-splits.nvim"},
    {"folke/zen-mode.nvim"},

    {"RRethy/vim-illuminate"},

    {
        "Shatur/neovim-session-manager",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },

    { "Eandrju/cellular-automaton.nvim" },

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
        config = function()
            require("aerial").setup()
        end,
    },

    { "karb94/neoscroll.nvim" },

    { "christoomey/vim-tmux-navigator" },

    {"wakatime/vim-wakatime"},
})
