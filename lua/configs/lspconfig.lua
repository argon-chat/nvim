require("nvchad.configs.lspconfig").defaults()

local servers = {
	"html", "cssls", "solargraph", "gopls", "tsserver", "eslint",
    "csharp_ls", "clangd", "rust_analyzer", "zls"
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers