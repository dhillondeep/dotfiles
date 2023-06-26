local M = {}

M.plugins = "custom.plugin"
M.mappings = require("custom.mapping")

M.ui = {
  theme_toggle = { "dark_horizon", "dark_horizon" },
  theme = "dark_horizon",
  telescope = {
    style = "bordered"
  }
}

return M
