local actions = require("fzf-lua.actions")

local bat_args = os.getenv("BAT_ARGS") or "--style=numbers,changes --color always"
local bat_theme = "base16"
local fd_opts = os.getenv("FD_OPTS") or "--color=never --type f --hidden --follow --exclude .git"
local rg_opts = os.getenv("RG_OPTS")
    or "--column --line-number --no-heading --color=always --smart-case --max-columns=512"

require("fzf-lua").setup({
  winopts = {
    height  = 0.76, -- window height
    width   = 0.87, -- window width
    row     = 0.38, -- window row position (0=top, 1=bottom)
    col     = 0.46, -- window col position (0=left, 1=right)
    preview = {
      border     = "noborder",
      default    = "bat",
      scrollbar  = "false",
      vertical   = "down:55%",  -- up|down:size
      horizontal = "right:55%", -- right|left:size
    },
    border  = false,
    hl      = {
      normal = "TelescopeNormal",  -- window normal color (fg+bg)
      cursor = "TelescopeSelection",
      border = "FloatBorder",      -- border color
      help_normal = "Normal",      -- <F1> window normal
      help_border = "FloatBorder", -- <F1> window border
    },
  },
  fzf_opts = {
    ["--info"] = "inline",
    ["--layout"] = "reverse",
    ["--color"] = "pointer:129,marker:010",
    ["--ansi"] = "",
  },
  previewers = {
    bat = {
      cmd = "bat",
      args = bat_args,
      theme = bat_theme,
    },
  },
  files = {
    prompt = "Files❯   ",
    fd_opts = fd_opts .. " --type f --type s",
  },
  lines = {
    previewer = false,
    prompt = "Lines❯   ",
    color_icons = false,
  },
  blines = {
    previewer = false,
    prompt    = "BLines❯   ",
  },
  grep = {
    prompt = "Search❯   ",
    rg_opts = rg_opts,
    actions = {
      ["ctrl-g"] = { actions.grep_lgrep },
    },
    continue_last_search = false,
  },
  file_icon_colors = {
    ["sh"] = "green",
  },
  keymap = {
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<C-h>"] = "toggle-help",
      ["<C-f>"] = "toggle-fullscreen",
    },
    fzf = {
      ["ctrl-w"] = "toggle-preview-wrap",
      ["ctrl-p"] = "toggle-preview",
      ["ctrl-d"] = "preview-page-down",
      ["ctrl-u"] = "preview-page-up",
    },
  },
  actions = {
    files = {
      ["default"] = actions.file_edit_or_qf,
      ["ctrl-s"] = actions.file_split,
      ["ctrl-v"] = actions.file_vsplit,
      ["ctrl-t"] = actions.file_tabedit,
    },
  },
})
