-- Check if lazy.nvim is installed
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

-- Join two tables
local function join(t1, t2)
    for _, v in ipairs(t2) do
        table.insert(t1, v)
    end
    return t1
end

-- Add plugins here
-- Core plugins
local core_plugins = {
    { "nvim-treesitter/nvim-treesitter", name = "treesitter", lazy = false },
    { "williamboman/mason.nvim", name = "mason", build = ":MasonUpdate" },
    { "neovim/nvim-lspconfig", name = "lspconfig", lazy = false },
    { "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
}
-- Additional plugins
local additional_plugins = {
    { "hrsh7th/cmp-nvim-lsp", name = "cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer", name = "cmp-buffer" },
    { "hrsh7th/cmp-path", name = "cmp-path" },
    { "hrsh7th/cmp-cmdline", name = "cmp-cmdline" },
    { "hrsh7th/nvim-cmp", name = "nvim-cmp" },
    { 'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
}
-- Colorschemes
local colorschemes = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "jacoborus/tender.vim", name = "tender" },
    { "ellisonleao/gruvbox.nvim", priority = 1000 },
    { "rebelot/kanagawa.nvim", priority = 1000 },
    { "folke/tokyonight.nvim", priority = 1000 },
    { "arcticicestudio/nord-vim", priority = 1000 },
    { "olivercederborg/poimandres.nvim", priority = 1000 },
    { "EdenEast/nightfox.nvim", priority = 1000 },
}
local plugins = { }
plugins = join(plugins, core_plugins)
plugins = join(plugins, additional_plugins)
plugins = join(plugins, colorschemes)

-- Add options here
local options = {}

require("lazy").setup(plugins, options)

