return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- Language servers and formatters/linters for Ruby, Go, JS, TS
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "solargraph",    -- Ruby
          "gopls",         -- Go
          "tsserver",      -- JS/TS
          "eslint",        -- JS/TS linting
          "csharp_ls",     -- C#
          "clangd",        -- C/C++
          "rust_analyzer", -- Rust
          "zls",           -- Zig
          "phpactor",      -- PHP (or "intelephense")
          "pylsp",         -- Python (or "pyright")
        },
      }
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    config = function()
      require("mason-null-ls").setup {
        ensure_installed = {
          "prettier",      -- JS/TS formatter
          "eslint_d",      -- JS/TS linter
          "gofmt",         -- Go formatter
          "goimports",     -- Go formatter
          "rufo",          -- Ruby formatter
          "clang_format",  -- C/C++ formatter
          "csharpier",     -- C# formatter
          "rustfmt",       -- Rust formatter
          "zigfmt",        -- Zig formatter
          "php_cs_fixer",  -- PHP formatter
          "phpcs",         -- PHP linter
          "black",         -- Python formatter
          "isort",         -- Python import sorter
          "flake8",        -- Python linter
        },
      }
    end,
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
  -- GitLab repo: use url for lazy.nvim
  url = "https://gitlab.com/code-stats/code-stats-vim.git",
  event = "VeryLazy",                          -- load after startup
  init = function()
    -- safest: read token from env var
    vim.g.codestats_api_key = os.getenv("CODESTATS_API_KEY")
    -- or hardcode (not recommended):
    -- Optional: if you’re using a self-hosted Code::Stats server:
    -- vim.g.codestats_api_url = "https://your-codestats.example/api"
  end,
},
{
  "github/copilot.vim",
  cmd = { "Copilot" },        -- load plugin when you run :Copilot
  event = "InsertEnter",      -- also loads when you enter insert mode
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.keymap.set("i", "<C-l>", 'copilot#Accept("")',
      { expr = true, replace_keycodes = false, silent = true })
  end,
},
  { "nvim-lualine/lualine.nvim", event = "VeryLazy", config = function() require("lualine").setup({}) end },
  {
    "h4ckm1n-dev/kube-utils-nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    lazy = true,
    event = "VeryLazy"
  },
{
  'SuperBo/fugit2.nvim',
  build = false,
  opts = {
    width = 100,
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
    {
      'chrisgrieser/nvim-tinygit', -- optional: for Github PR view
      dependencies = { 'stevearc/dressing.nvim' }
    },
  },
  cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph' },
  keys = {
    { '<leader>F', mode = 'n', '<cmd>Fugit2<cr>' }
  }
},
-- {
--   "mfussenegger/nvim-dap",
--   dependencies = {
--     "rcarriga/nvim-dap-ui",
--     "jay-babu/mason-nvim-dap.nvim", -- optional, for adapter management
--   },
--   config = function()
--     local dap = require("dap")
--     local dapui = require("dapui")
--
--     dap.adapters.go = {
--       type = "executable",
--       command = "dlv",
--       args = { "dap" },
--     }
--
--     dap.configurations.go = {
--       {
--         type = "go",
--         name = "Debug",
--         request = "launch",
--         program = "${file}",
--       },
--     }
--
--     dapui.setup()
--
--     -- Optional: auto open/close dap-ui
--     dap.listeners.after.event_initialized["dapui_config"] = function()
--       dapui.open()
--     end
--     dap.listeners.before.event_terminated["dapui_config"] = function()
--       dapui.close()
--     end
--     dap.listeners.before.event_exited["dapui_config"] = function()
--       dapui.close()
--     end
--
--     -- Keybindings
--     vim.keymap.set("n", "<F5>", dap.continue)
--     vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
--     vim.keymap.set("n", "<F10>", dap.step_over)
--     vim.keymap.set("n", "<F11>", dap.step_into)
--     vim.keymap.set("n", "<F12>", dap.step_out)
--   end,
-- },
-- {
--   "jay-babu/mason-nvim-dap.nvim",
--   config = function()
--     require("mason-nvim-dap").setup({
--       ensure_installed = { "delve" },
--     })
--   end,
-- },
--   -- test new blink
}
