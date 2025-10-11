return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local cmp = require("cmp")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Mason setup
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "pyright", "lua_ls", "hls" },
        })

        -- Diagnostics config
        vim.diagnostic.config({
            virtual_text = {
                prefix = "●",
                source = "if_many",
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show error message" })

        -- Use the new LSP config / enable API

        -- Python server
        vim.lsp.config("pyright", {
            capabilities = capabilities,
        })

        -- Haskell LSP
        vim.lsp.config("hls", {
            capabilities = capabilities,
            settings = {
                haskell = {
                    formattingProvider = "ormolu", -- or "fourmolu", "brittany", etc.
                    plugin = {
                        rename = { globalOn = true },
                        hlint = { diagnosticsOn = true },
                    },
                },
            },
        })

        -- Lua server
        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        -- Actually enable the servers
        vim.lsp.enable({ "pyright", "lua_ls" })

        -- Autocompletion setup
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
            }),
        })
    end,
}
