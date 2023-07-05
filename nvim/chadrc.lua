local M = {}

M.plugins = "custom.plugin"
M.mappings = require("custom.mapping")

M.ui = {
  theme_toggle = { "onedark", "onedark" },
  theme = "onedark",
  telescope = {
    style = "bordered"
  }
}

return M
