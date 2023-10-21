dofile(vim.g.base46_cache .. "lsp")
require "nvchad.lsp"

local utils = require("core.utils")
local lspformat = require("lsp-format")

lspformat.setup {
  on_save = false,
}

-- on_attach function
local function on_attach(client, bufnr)
  lspformat.on_attach(client)

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end
end

-- capabilities
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp_capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}


local lspconfig = require("lspconfig")
local nulls = require("null-ls")

local server_cfg = require("custom.config.lsp_options")
local nullls_cfg = require("custom.config.nullls_options")

for _, server in ipairs(deepvim.opts.lsp.servers) do
  local cfg = server_cfg[server]()

  local capabilities = lsp_capabilities
  if cfg.capabilities ~= nil then
    capabilities = vim.tbl_deep_extend("force", capabilities, cfg.capabilities)
  end

  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  if cfg.config ~= nil then
    opts.settings = cfg.config
  end
  if cfg.root_dir ~= nil then
    opts.root_dir = cfg.root_dir
  end
  lspconfig[cfg.name].setup(opts)
end

local nullls_sources = {}
for _, server in ipairs(deepvim.opts.nulls.servers) do
  local cfg = nullls_cfg[server]()
  table.insert(nullls_sources, cfg)
end

nulls.setup({
  on_attach = on_attach,
  sources = nullls_sources,
})
