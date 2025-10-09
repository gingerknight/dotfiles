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
        local lspconfig = require("lspconfig")
        local cmp = require("cmp")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Mason setup
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "pyright", "lua_ls" },
        })

        -- 🔹 Show diagnostic messages inline + in popup
        vim.diagnostic.config({
            virtual_text = {
                prefix = "●", -- any symbol you like
                source = "if_many",
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        -- 🔹 Keymap to open full error in float
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show error message" })

        -- Python LSP
        lspconfig.pyright.setup({
            capabilities = capabilities,
        })

        -- Lua LSP (Neovim config development)
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                },
            },
        })

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
