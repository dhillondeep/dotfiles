return {
  ["gopls"] = function()
    return {
      name = "gopls",
      capabilities = {
        documentFormattingProvider = true,
        documentRangeFormattingProvider = true,
      },
    }
  end,
  ["pyright"] = function()
    return {
      name = "pyright",
      capabilities = {
        documentFormattingProvider = false,
        documentRangeFormattingProvider = false,
      },
      config = {
        python = {
          analysis = {
            autoSearchPaths = true,
            typeCheckingMode = "basic",
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true
          },
        },
      },
    }
  end,
  ["ruff_lsp"] = function()
    return {
      name = "ruff_lsp",
      capabilities = {
        documentFormattingProvider = true,
        documentRangeFormattingProvider = true,
      },
      on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false

        local ruff_lsp_client = require("lspconfig.util").get_active_client_by_name(bufnr, "ruff_lsp")
        local request = function(method, params)
          ruff_lsp_client.request(method, params, nil, bufnr)
        end

        local organize_imports = function()
          request("workspace/executeCommand", {
            command = "ruff.applyOrganizeImports",
            arguments = {
              { uri = vim.uri_from_bufnr(bufnr) },
            },
          })
        end

        local format = function()
          organize_imports()
          vim.lsp.buf.format { async = true }
        end

        vim.api.nvim_create_user_command(
          "RuffOrganizeImports",
          organize_imports,
          { desc = "Ruff: Organize Imports" }
        )

        vim.api.nvim_create_user_command(
          "RuffFormat",
          format,
          { desc = "Ruff: Format" }
        )

        require("core.utils").load_mappings("rufflsp", { buffer = bufnr })
      end,
    }
  end,
  ["lua_ls"] = function()
    return {
      name = "lua_ls",
      capabilities = {
        documentFormattingProvider = true,
        documentRangeFormattingProvider = true,
      },
      config = {
        Lua = {
          checkThirdParty = false,
          completion = {
            callSnippet = "Replace"
          },
          diagnostics = {
            globals = { "vim", "deepvim" },
          },
        },
      },
    }
  end,
  ["vimls"] = function()
    return {
      name = "vimls",
    }
  end,
  ["jsonls"] = function()
    return {
      name = "jsonls",
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    }
  end,
  ["yamlls"] = function()
    return {
      name = "yamlls",
      schemas = require('schemastore').yaml.schemas(),
      validate = { enable = false },
    }
  end,
  ["bashls"] = function()
    return {
      name = "bashls",
    }
  end,
}
