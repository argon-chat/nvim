require "nvchad.options"

local enable_providers = {
    "python3_provider",
    "node_provider",
    -- and so on
}

vim.opt.colorcolumn = "79"
vim.opt.relativenumber = true
vim.opt.completeopt = { "menuone", "noselect", "popup" } 
local lsp = require("lspconfig")
local fn = vim.fn
local cmp = require("cmp")
local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_lsp.default_capabilities()

for _, plugin in pairs(enable_providers) do
    vim.g["loaded_" .. plugin] = nil
    vim.cmd("runtime " .. plugin)
end

require("lualine").setup({
  sections = {
    lualine_x = {
      function() return fn["CodeStatsXp"]() end,  -- shows Code::Stats XP queue
      "encoding", "filetype"
    },
  },
})
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = {"*.js", "*.ts", "*.jsx", "*.tsx"},
  callback = function()
    local file = fn.expand("%:p")
    fn.system({"bunx", "biome", "format", "--write", file})
    fn.system({"bunx", "biome", "lint", "--write", file})
    vim.cmd("edit!") -- reload the file after formatting
  end,
  desc = "Run biome lint on save"
})
-- Buffer-local LSP keymaps
local on_attach = function(client, bufnr)
  vim.lsp.completion.enable(true, client.id, bufnr, {
		autotrigger = true,
		convert = function(item)
          return { abbr = item.label:gsub("%b()", "") }
		end,
  })
  vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "trigger autocompletion" })
  local map = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true }) end
  map("n", "gd", vim.lsp.buf.definition)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "K",  vim.lsp.buf.hover)
  map("n", "<leader>rn", vim.lsp.buf.rename)
  map("n", "<leader>ca", vim.lsp.buf.code_action)
  map("n", "gl", vim.diagnostic.open_float)
end

-- Root detection to avoid random startup
local util = require("lspconfig.util")
local roots = {
  node = util.root_pattern("package.json", "tsconfig.json", ".git"),
  go   = util.root_pattern("go.work", "go.mod", ".git"),
  ruby = util.root_pattern("Gemfile", ".ruby-version", ".git"),
  cs   = util.root_pattern("*.sln", "*.csproj", ".git"),
  py   = util.root_pattern("pyproject.toml", "requirements.txt", ".git"),
  java = util.root_pattern("pom.xml", "build.gradle", "settings.gradle", ".git"),
}

-- JS/TS (note: tsserver is ts_ls in recent lspconfig)
lsp.ts_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = roots.node,
})

-- Go
lsp.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = roots.go,
  settings = { gopls = { gofumpt = true } },
})

-- Ruby
lsp.solargraph.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = roots.ruby,
})

-- C#
lsp.omnisharp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = roots.cs,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
})
