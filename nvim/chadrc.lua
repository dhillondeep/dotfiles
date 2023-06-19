local M = {}

M.plugins = "custom.plugin"
M.mappings = require("custom.mapping")

M.ui = {
  theme_toggle = { "pastelDark", "kanagawa" },
  theme = "pastelDark",
  telescope = {
    style = "bordered"
  }
}

return M
