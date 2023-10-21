local actions = require("fzf-lua.actions")


local config = {
  'telescope',
  fzf_opts = {
    ["--info"] = "inline",
    ["--layout"] = "reverse",
    ["--color"] = "pointer:129,marker:010",
    ["--ansi"] = "",
  },
  previewers = {
    bat = {
      cmd = "bat",
      theme = "base16",
    },
  },
  files = {
    prompt = "Files❯   ",
  },
  grep = {
    prompt = "Search❯   ",
    actions = {
      ["ctrl-g"] = { actions.grep_lgrep },
    },
    continue_last_search = false,
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
}

local bat_opts_env = os.getenv("BAT_ARGS")
if bat_opts_env then
  config.previewers.bat.args = bat_opts_env
end

local rg_opts_env = os.getenv("RG_OPTS")
if rg_opts_env then
  config.grep.rg_opts = rg_opts_env
end

local fd_opts_env = os.getenv("FD_OPTS")
if fd_opts_env then
  config.files.fd_opts = fd_opts_env
end

require("fzf-lua").setup(config)
