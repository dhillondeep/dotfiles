local M = {}

M.plugins = "custom.plugin"
M.mappings = require("custom.mapping")

M.ui = {
  theme_toggle = { "ayu_dark", "ayu_dark" },
  theme = "ayu_dark",
  telescope = {
    style = "bordered"
  }
}

return M
