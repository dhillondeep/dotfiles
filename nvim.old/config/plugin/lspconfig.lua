dofile(vim.g.base46_cache .. "lsp")
require "nvchad.lsp"

local utils = require("core.utils")

-- on_attach function
local function on_attach(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
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

  local on_attach_func = on_attach
  if cfg.on_attach ~= nil then
    on_attach_func = function(client, bufnr)
      on_attach(client, bufnr)
      cfg.on_attach(client, bufnr)
    end
  end

  local opts = {
    on_attach = on_attach_func,
    capabilities = capabilities,
    commands = cfg.commands or {},
    init_options = cfg.init_options or {},
    settings = cfg.config or {}
  }
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
