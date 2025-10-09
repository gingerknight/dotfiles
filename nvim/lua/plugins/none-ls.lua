return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            debug = true,
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.completion.spell,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.prettier,
                require("none-ls.diagnostics.eslint_d"),
                require("none-ls.diagnostics.flake8"),
            },
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    local group = vim.api.nvim_create_augroup("LspFormatting", { clear = false})
                    vim.api.nvim_clear_autocmds({ group = "LspFormatting", buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = group,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}

