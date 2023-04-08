local present, lspconfig = pcall(require, "lspconfig")
if not present then
	return
end

dofile(vim.g.base46_cache .. "lsp")
require("nvchad_ui.lsp")

local utils = require("core.utils")

-- on_attach function
local function on_attach(client, bufnr)
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
			require("null-ls").setup({
				on_attach = on_attach,
				sources = sources,
			})
		end
	end
end
