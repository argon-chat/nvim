require "nvchad.options"

local enable_providers = {
    "python3_provider",
    "node_provider",
    -- and so on
}

vim.opt.colorcolumn = "79"
vim.opt.relativenumber = true
vim.opt.completeopt = { "menuone", "noselect", "popup" } 
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
local roots = {
  node = {".git", "package.json", "tsconfig.json"},
  go   = {".git", "go.work", "go.mod"},
  ruby = {".git", "Gemfile", ".ruby-version"},
  cs   = {".git", "*.sln", "*.csproj"},
  py   = {".git", "pyproject.toml", "requirements.txt", "setup.py"},
  java = {".git", "pom.xml", "build.gradle", "settings.gradle"},
  c    = {".git", "Makefile", "CMakeLists.txt", "compile_commands.json"},
  cpp  = {".git", "Makefile", "CMakeLists.txt", "compile_commands.json"},
  rust = {".git", "Cargo.toml"},
  zig  = {".git", "build.zig"},
  php  = {".git", "composer.json", "composer.lock"},
}

-- JS/TS (note: tsserver is ts_ls in recent lspconfig)
vim.lsp.config.ts_ls = {
  capabilities = capabilities,
  on_attach = on_attach,
  root_markers = roots.node,
  single_file_support = true,  -- This allows LSP to work on standalone files
}

-- Go
vim.lsp.config.gopls = {
  capabilities = capabilities,
  on_attach = on_attach,
  root_markers = roots.go,
  single_file_support = true,  -- This allows LSP to work on standalone files
  settings = { gopls = { gofumpt = true } },
}

-- Ruby
vim.lsp.config.solargraph = {
  capabilities = capabilities,
  on_attach = on_attach,
  root_markers = roots.ruby,
  single_file_support = true,  -- This allows LSP to work on standalone files
}

-- C#
vim.lsp.config.omnisharp = {
  capabilities = capabilities,
  on_attach = on_attach,
  root_markers = roots.cs,
  single_file_support = true,  -- This allows LSP to work on standalone files
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
}

-- C/C++
vim.lsp.config.clangd = {
  capabilities = capabilities,
  on_attach = on_attach,
  root_markers = roots.cpp,
  cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
  single_file_support = true,  -- This allows LSP to work on standalone files
}

-- Rust
vim.lsp.config.rust_analyzer = {
  capabilities = capabilities,
  on_attach = on_attach,
  root_markers = roots.rust,
  single_file_support = true,  -- This allows LSP to work on standalone files
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = true,
      check = { command = "clippy" },
    },
  },
}

-- Zig
vim.lsp.config.zls = {
  capabilities = capabilities,
  on_attach = on_attach,
  root_markers = roots.zig,
  single_file_support = true,  -- This allows LSP to work on standalone files
}

-- PHP
vim.lsp.config.phpactor = {
  capabilities = capabilities,
  on_attach = on_attach,
  root_markers = roots.php,
  single_file_support = true,  -- This allows LSP to work on standalone files
}

-- Python
vim.lsp.config.pylsp = {
  capabilities = capabilities,
  on_attach = on_attach,
  root_markers = roots.py,
  single_file_support = true,  -- This allows LSP to work on standalone files
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
        pyflakes = { enabled = false },
        flake8 = { enabled = true },
        black = { enabled = true },
        isort = { enabled = true },
      },
    },
  },
}
