--- global configuration functions ---
--------------------------------------

local cfg = {}

-- Configuration for lsp servers
function cfg.lspserver_cfgs()
  return {
    ["lua_ls"] = {
      Lua = {
        diagnostics = {
          globals = { "vim", "deepvim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
            [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
    ["pyright"] = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "basic",
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true
        }
      }
    },
    ["jsonls"] = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
    ["yamlls"] = {
      yaml = {
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  }
end

-- Configurations for global highlights
function cfg.set_highlights(base46)
  local colors = base46.get_theme_tb("base_30")

  local highlights = {
    -- global generic highlights
    DeepNvimBorder = { fg = colors.grey },
    DeepNvimTitleBg = { bg = colors.red, fg = colors.black, bold = true },
    DeepNvimTitle = { fg = colors.red, bold = true },
    DeepNvimTitleAltBg = { bg = colors.green, fg = colors.black, bold = true },
    DeepNvimTitleAlt = { fg = colors.green, bold = true },
    DeepNvimSelection = { bg = colors.black2, fg = colors.white, bold = true },
    DeepNvimContent = { fg = colors.white },
    FloatBorder = { link = "DeepNvimBorder" },
  }

  for group, conf in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, conf)
  end
end

deepvim.cfg = cfg
