local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup {
	ensure_installed = { "tsserver", "pylsp", "sumneko_lua" }
}

require'lspconfig'.pylsp.setup {
	capabilities = capabilities
}
require'lspconfig'.sumneko_lua.setup {
	capabilities = capabilities
}
require'lspconfig'.clangd.setup {
	capabilities = capabilities,
}
require'lspconfig'.tsserver.setup {
	capabilities = capabilities
}

