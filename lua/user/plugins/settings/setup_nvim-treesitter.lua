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

