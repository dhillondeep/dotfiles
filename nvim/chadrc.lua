local M = {}

M.plugins = "custom.plugin"
M.mappings = require("custom.mapping")

M.ui = {
  theme_toggle = { "bearded-arc", "bearded-arc" },
  theme = "bearded-arc",
  telescope = {
    style = "bordered"
  }
}

return M
