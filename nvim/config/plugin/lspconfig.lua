local present, lspconfig = pcall(require, "lspconfig")
if not present then
	return
end

dofile(vim.g.base46_cache .. "lsp")
require("nvchad_ui.lsp")

local utils = require("core.utils")
local navbuddy = require("nvim-navbuddy")

-- on_attach function
local function on_attach(client, bufnr)
	client.server_capabilities.documentFormattingProvider = true
	client.server_capabilities.documentRangeFormattingProvider = true

	utils.load_mappings("lspconfig", { buffer = bufnr })

	-- Format command
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		vim.lsp.buf.format({
			format_on_save = false,
		})
	end, { desc = "Format file with LSP" })

	if client.server_capabilities.signatureHelpProvider then
		require("nvchad_ui.signature").setup(client)
	end

	navbuddy.attach(client, bufnr)
end

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
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

local servers_cfgs = deepvim.cfg.lspserver_cfgs()
local lsp_cfg = deepvim.opts.lsp[vim.bo.filetype]

if lsp_cfg ~= nil then
	-- setup null-ls if enabled
	if lsp_cfg["enable_nulls"] ~= nil then
		local present2, nullls = pcall(require, "null-ls")
		if not present2 then
			return
		end
		nullls.setup({
			on_attach = on_attach,
			sources = deepvim.cfg.nullls_sources(nullls),
		})
	end
	-- setup servers
	for _, server in ipairs(lsp_cfg["servers"]) do
		-- setup lsp servers
		local opts = {
			on_attach = on_attach,
			capabilities = capabilities,
		}
		local config = servers_cfgs[server]
		if config ~= nil then
			opts.settings = config
		end
		lspconfig[server].setup(opts)
	end
end
