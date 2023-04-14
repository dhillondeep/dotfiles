dofile(vim.g.base46_cache .. "lsp")
require("nvchad_ui.lsp")

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


local M = {}

function M.setup_servers()
	local lspconfig = require("lspconfig")
	local nulls = require("null-ls")

	local lsp_cfg = deepvim.opts.lsp[vim.bo.filetype]
	local server_cfg = require("custom.config.lsp_options")
	local nullls_cfg = require("custom.config.nullls_options")

	if lsp_cfg ~= nil then
		if lsp_cfg.servers ~= nil then
			for _, server in ipairs(lsp_cfg.servers) do
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
				lspconfig[cfg.name].setup(opts)
			end
		end

		if lsp_cfg.nullls ~= nil then
			local sources = {}
			for _, source in ipairs(lsp_cfg.nullls) do
				local cfg = nullls_cfg[source]()
				table.insert(sources, cfg)
			end

			if next(sources) ~= nil then
				nulls.setup({
					on_attach = on_attach,
					sources = sources,
				})
			end
		end
	end
end

return M
