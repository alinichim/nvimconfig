local lspconfig = require("lspconfig")

-- Add here other LSP servers
lspconfig.clangd.setup { } -- C/C++ LSP
lspconfig.gopls.setup { }  -- Go LSP
lspconfig.rust_analyzer.setup { }  -- Rust LSP
lspconfig.pylsp.setup { }  -- Python LSP
lspconfig.texlab.setup { }  -- Latex LSP
