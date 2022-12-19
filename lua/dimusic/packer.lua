vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = { { "nvim-lua/plenary.nvim" } },
    })

    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    })

    use({
        "sainnhe/everforest",
        config = function()
            --	vim.cmd('colorscheme everforest')
        end,
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        -- run = ":TSUpdate",
    })
    use("nvim-treesitter/playground")

    use("theprimeagen/harpoon")

    use("mbbill/undotree")

    use({
        "simrat39/rust-tools.nvim",
        config = function()
            local rt = require("rust-tools")

            rt.setup({
                server = {
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                        -- Code action groups
                        --vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                    end,
                },
            })
        end,
    })

    use({
        "VonHeikemen/lsp-zero.nvim",
        requires = {
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
    })

    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })

    use("onsails/lspkind.nvim")

    use({
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({})
        end,
    })

    use({
        "anuvyklack/windows.nvim",
        requires = "anuvyklack/middleclass",
        config = function()
            require("windows").setup()
        end,
    })

    use({ "windwp/nvim-autopairs" })

    use({
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup()
        end,
    })

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    use("lukas-reineke/indent-blankline.nvim")

    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    })

    use("j-hui/fidget.nvim")

    use({
        "akinsho/toggleterm.nvim",
        tag = "*",
    })

    use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

    use("vim-scripts/zoom.vim")

    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    })

    use("lewis6991/gitsigns.nvim")

    use({
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    })

    use("mrjones2014/smart-splits.nvim")

    use("wakatime/vim-wakatime")
end)
