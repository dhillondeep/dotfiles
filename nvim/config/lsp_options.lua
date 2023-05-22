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
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true
          },
        },
      },
    }
  end,
  ["lua_ls"] = function()
    require("neodev").setup({})

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
    }
  end,
  ["yamlls"] = function()
    return {
      name = "yamlls",
    }
  end,
  ["bashls"] = function()
    return {
      name = "bashls",
    }
  end,
}
