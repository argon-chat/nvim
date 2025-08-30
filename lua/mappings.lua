
require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Tab navigation with <leader><Left> and <leader><Right>
-- Buffer navigation with <leader><Left> and <leader><Right>
-- Focus NvimTree with <leader>e
-- Focus NvimTree with <leader>n
-- Multi-key mapping: <leader>fe to focus NvimTree
-- Show errors in current file with <leader>ee
-- LSP context menus on <leader> arrow keys
map("n", "<leader>c<Down>", function() vim.diagnostic.open_float() end, { desc = "Show diagnostics popup" })
map("n", "<leader>c<Up>", function() vim.lsp.buf.hover() end, { desc = "Show hover info" })
map("n", "<leader>c<Left>", function() vim.lsp.buf.signature_help() end, { desc = "Show signature help" })
map("n", "<leader>c<Right>", function() vim.lsp.buf.code_action() end, { desc = "Show code actions" })
map("n", "<leader>ee", ":lua vim.diagnostic.setqflist()<CR>", { desc = "Show errors in file" })
map("n", "<leader>fe", ":NvimTreeFocus<CR>", { desc = "Focus NvimTree (multi-key)" })
map("n", "<leader><Left>", ":bprev<CR>", { desc = "Go to previous buffer" })
map("n", "<leader><Right>", ":bnext<CR>", { desc = "Go to next buffer" })
-- Kubernetes Group Titles
map("n", "<leader>k", function() end, { desc = "Kubernetes" })

-- Helm Commands
map("n", "<leader>kh", function() end, { desc = "Helm" })
map("n", "<leader>khT", "<cmd>HelmDryRun<CR>", { desc = "Helm DryRun Buffer" })
map("n", "<leader>khb", "<cmd>HelmDependencyBuildFromBuffer<CR>", { desc = "Helm Dependency Build" })
map("n", "<leader>khd", "<cmd>HelmDeployFromBuffer<CR>", { desc = "Helm Deploy Buffer to Context" })
map("n", "<leader>khr", "<cmd>RemoveDeployment<CR>", { desc = "Helm Remove Deployment From Buffer" })
map("n", "<leader>kht", "<cmd>HelmTemplateFromBuffer<CR>", { desc = "Helm Template From Buffer" })
map("n", "<leader>khu", "<cmd>HelmDependencyUpdateFromBuffer<CR>", { desc = "Helm Dependency Update" })

-- Kubectl Commands
map("n", "<leader>kk", function() end, { desc = "Kubectl" })
map("n", "<leader>kkC", "<cmd>SelectSplitCRD<CR>", { desc = "Download CRD Split" })
map("n", "<leader>kkD", "<cmd>DeleteNamespace<CR>", { desc = "Kubectl Delete Namespace" })
map("n", "<leader>kkK", "<cmd>OpenK9s<CR>", { desc = "Open K9s" })
map("n", "<leader>kka", "<cmd>KubectlApplyFromBuffer<CR>", { desc = "Kubectl Apply From Buffer" })
map("n", "<leader>kkc", "<cmd>SelectCRD<CR>", { desc = "Download CRD" })
map("n", "<leader>kkk", "<cmd>OpenK9sSplit<CR>", { desc = "Split View K9s" })
map("n", "<leader>kkl", "<cmd>ToggleYamlHelm<CR>", { desc = "Toggle YAML/Helm" })

-- Logs Commands
map("n", "<leader>kl", function() end, { desc = "Logs" })
map("n", "<leader>klf", "<cmd>JsonFormatLogs<CR>", { desc = "Format JSON" })
map("n", "<leader>klv", "<cmd>ViewPodLogs<CR>", { desc = "View Pod Logs" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
