-- ~/.config/nvim/lua/vim-options.lua
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=0")
vim.cmd("set shiftwidth=4")
vim.cmd("set textwidth=120") --- Text width to force word wrap

vim.g.mapleader = " "

-- Line numbers
vim.opt.number = true

-- Enable mouse
vim.opt.mouse = "a"

-- Persistent undo
vim.opt.undofile = true

-- Show whitespace
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Live substitution preview
vim.opt.inccommand = "split"

-- Highlight current line
vim.opt.cursorline = true

-- Recenter cursor line veritically after scrolling half-page up/downs
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- In normal and visual mode, yank text into clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Format Prettier
vim.keymap.set("n", "<leader>pf", ":!npm run format<CR>", { silent = true })
