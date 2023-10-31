-- Setup lazy.nvim
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

-- Add plugins here
plugins = {
    { "nvim-treesitter/nvim-treesitter", name = "treesitter", lazy = false },
    { "neovim/nvim-lspconfig", name = "lspconfig", lazy = false },
    { "nvim-tree/nvim-tree.lua", name = "nvim-tree", lazy = false },
    { "hrsh7th/cmp-nvim-lsp", name = "cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer", name = "cmp-buffer" },
    { "hrsh7th/cmp-path", name = "cmp-path" },
    { "hrsh7th/cmp-cmdline", name = "cmp-cmdline" },
    { "hrsh7th/nvim-cmp", name = "nvim-cmp" },
    { "mfussenegger/nvim-lint", name = "lint" },
    { "mfussenegger/nvim-jdtls", name = "jdtls" },
    { "mhartington/formatter.nvim", name = "formatter" },
    { "williamboman/mason.nvim", name = "mason", build = ":MasonUpdate" },
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "jacoborus/tender.vim", name = "tender" },
    { "ellisonleao/gruvbox.nvim", priority = 1000 },
    { "rebelot/kanagawa.nvim", priority = 1000 },
    { "folke/tokyonight.nvim", priority = 1000 },
    { "arcticicestudio/nord-vim", priority = 1000 },
    { "olivercederborg/poimandres.nvim", priority = 1000 },
    { "lukas-reineke/indent-blankline.nvim" },
    { "norcalli/nvim-colorizer.lua", name = "colorizer" },
    { "Exafunction/codeium.vim" },
}

require("lazy").setup(plugins, opts)

require("tokyonight").setup {
  style = "night",
  transparent = true,
}

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd.colorscheme "tokyonight"

-- Set background transparent
vim.cmd('highlight NvimTree ctermbg=none guibg=none')
-- vim.cmd.highlight "Normal guibg=none ctermbg=none"

-- Set line number
vim.opt.number = true

-- Configure tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Configure key maps
vim.keymap.set('n', '<C-e>', ':NvimTreeFocus<CR>')

-- Configure nvim-colorizer
require("colorizer").setup()

-- Configure key maps for Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Configure nvim-treesitter
require('nvim-treesitter.configs').setup {
  -- List of parser names
  ensure_installed = { "c", "lua", "vim", "vimdoc", "go" },

  -- Install parsers synchronously
  sync_install = false,

  -- Automatically install parsers
  auto_install = true,

  -- Highlighting
  highlight = {
    enable = true,

    -- Parsers to be ignored
    disable = {},
  },
  -- Incremental selection
  incremental_selection = {
    enable = true,
  },
  -- Indentation
  indent = {
    enable = false,
  },
}

-- Configure nvim-lspconfig
local lspconfig = require("lspconfig")
lspconfig.clangd.setup { } -- C/C++ LSP
lspconfig.gopls.setup { }  -- Go LSP
lspconfig.rust_analyzer.setup { }  -- Rust LSP
lspconfig.pylsp.setup { }  -- Python LSP
lspconfig.jdtls.setup {
    cmd = {
        "/home/alinichim/.local/share/nvim/mason/packages/jdtls/bin/jdtls", "-configuration", "/home/alinichim/.cache/jdtls/config", "-data", "/home/alinichim/.cache/jdtls/workspace"
    },
}  -- Java LSP
lspconfig.arduino_language_server.setup { }  -- Arduino LSP
lspconfig.rome.setup { }  -- HTML, CSS LSP

-- Configure nvim-cmp
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }),
})

-- Configure formatter.nvim
require("formatter").setup {
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
        c = {
            function()
                return {
                    exe = "clang-format",
                    args = {
                        "--style=Google",
                        "--assume-filename",
                        vim.fn.expand('%:p'),
                    },
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h'),
                }
	        end
        },
        cpp = {
            function()
                return {
                    exe = "clang-format",
                    args = {
                        "--style=Google",
                        "--assume-filename",
                        vim.fn.expand('%:p'),
                    },
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h'),
                }
	        end
        },
        java = {
            function()
                return {
                    exe = "java",
                    args = {
                        "-jar",
                        "/home/alinichim/.local/share/nvim/mason/packages/google-java-format/google-java-format-1.17.0-all-deps.jar",
                        "--aosp",
                        "-",
                    },
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h'),
                }
            end
        },
        python = {
            function()
                return {
                    exe = "autopep8",
                    args = {
                        "--aggressive",
                        "--aggressive",
                        "-",
                    },
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h'),
                }
            end
        },
        rust = {
            function()
                return {
                    exe = "rustfmt",
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h'),
                }
            end
        },
        javascript = {
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.fn.expand('%:p'),
                    },
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h'),
                }
            end
        },
        typescript = {
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.fn.expand('%:p'),
                    },
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h'),
                }
            end
        },
        html = {
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.fn.expand('%:p'),
                    },
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h'),
                }
            end
        },
        css = {
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        vim.fn.expand('%:p'),
                    },
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h'),
                }
            end
        },
    }
}
vim.cmd("autocmd BufWritePost * FormatWrite")

-- Configure nvim-lint
require("lint").linters_by_ft = {}

-- Configure mason
require("mason").setup()

-- Configure nvim-tree
require("nvim-tree").setup()
