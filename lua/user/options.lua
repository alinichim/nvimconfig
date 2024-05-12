-- Set line number
vim.opt.relativenumber = true

-- Configure tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- diagnostics
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
    signs = false,
    underline = false,
})
