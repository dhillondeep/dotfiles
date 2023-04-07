local present, lspconfig = pcall(require, "lspconfig")
if not present then
	return
end

dofile(vim.g.base46_cache .. "lsp")
require("nvchad_ui.lsp")

local utils = require("core.utils")

-- on_attach function
local function generate_on_attach(lsp_cfg)
	return function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = true

		if lsp_cfg ~= nil and lsp_cfg.server_capabilities ~= nil then
			client.server_capabilities = vim.tbl_deep_extend("force", client.server_capabilities, lsp_cfg.server_capabilities)
		end

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
	end
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
	if lsp_cfg["nullls_sources"] ~= nil then
		local present2, nullls = pcall(require, "null-ls")
		if not present2 then
			return
		end
		nullls.setup({
			on_attach = generate_on_attach(nil),
			sources = lsp_cfg["nullls_sources"](nullls),
		})
	end
	-- setup servers
	for _, server in ipairs(lsp_cfg["servers"]) do
		-- setup lsp servers
		local opts = {
			on_attach = generate_on_attach(lsp_cfg),
			capabilities = capabilities,
		}
		local config = servers_cfgs[server]
		if config ~= nil then
			opts.settings = config
		end
		lspconfig[server].setup(opts)
	end
end
