local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
local logo = [[









                                             
      ████ ██████           █████      ██
     ███████████             █████ 
     █████████ ███████████████████ ███   ███████████
    █████████  ███    █████████████ █████ ██████████████
   █████████ ██████████ █████████ █████ █████ ████ █████
 ███████████ ███    ███ █████████ █████ █████ ████ █████
██████  █████████████████████ ████ █████ █████ ████ ██████
]]
dashboard.section.header.val = vim.split(logo, "\n")
dashboard.section.buttons.val = {
  dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
  dashboard.button("s", "  Find session", ":SessionManager load_session<CR>"),
  dashboard.button("t", "  Find text", ":FzfLua live_grep_native <CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.opts.layout[1].val = 6

alpha.setup(dashboard.opts)
