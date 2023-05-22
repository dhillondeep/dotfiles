local M = {}

M.plugins = "custom.plugin"
M.mappings = require("custom.mapping")

M.ui = {
  theme_toggle = { "onedark", "kanagawa" },
  theme = "onedark",
  nvdash = {
    load_on_startup = true,
    buttons = {
      { "  Find Session", "Spc f s", "Telescope persisted" },
      { "  Find File",    "Spc f f", "Telescope find_files" },
      { "  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "  Find Word",    "Spc f w", "Telescope live_grep" },
    },
  },
  telescope = {
    style = "bordered"
  }
}

return M
