local manager = {
  lspconfig_ft_visited = {},
}

function manager.configure_fzflua()
  require("custom.config.plugin.fzflua")
end

function manager.get_mason_opts()
  local nullls_cfg = require("custom.config.nullls_options")
  local ensure_installed = {}
  -- get nullls servers
  for key, _ in pairs(nullls_cfg) do
    table.insert(ensure_installed, key)
  end

  return {
    ensure_installed = ensure_installed,
  }
end

function manager.configure_mason_lspconfig()
  local lsp_cfg = require("custom.config.lsp_options")
  local ensure_installed = {}
  -- get lsp servers
  for key, _ in pairs(lsp_cfg) do
    table.insert(ensure_installed, key)
  end

  require("mason-lspconfig").setup {
    ensure_installed = ensure_installed,
  }
end

function manager.configure_lspconfig()
  require("custom.config.plugin.lspconfig")
end

function manager.configure_devicons()
  require("custom.config.plugin.devicons")
end

function manager.configure_guess_indent()
  require("guess-indent").setup({
    filetype_exclude = {
      "netrw",
      "tutor",
      "neo-tree",
      "NvimTree",
    },
    buftype_exclude = {
      "help",
      "nofile",
      "terminal",
      "prompt",
    },
  })
end

function manager.get_treesitter_opts()
  local opts = deepvim.opts.ts

  return {
    ensure_installed = opts.languages,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = function(lang, buf)
        if vim.tbl_contains({ "latex" }, lang) then
          return true
        end

        local status_ok, big_file_detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
        return status_ok and big_file_detected
      end,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
      config = {
        -- Languages that have a single comment style
        typescript = "// %s",
        css = "/* %s */",
        scss = "/* %s */",
        html = "<!-- %s -->",
        svelte = "<!-- %s -->",
        vue = "<!-- %s -->",
        json = "",
      },
    },
    indent = { enable = true, disable = { "yaml", "python" } },
    rainbow = {
      enable = true,
      disable = opts.rainbow_disable,
      extended_mode = false,
      max_file_lines = 1000,
    },
    autotag = { enable = true },
    incremental_selection = { enable = true },
  }
end

function manager.configure_project()
  require("project_nvim").setup({
    patterns = {
      ".git",
      "_darcs",
      ".hg",
      ".bzr",
      ".svn",
      "Makefile",
      "package.json",
      "!node_modules",
    },
  })
end

function manager.get_nvim_tree_opts()
  return {
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
  }
end

function manager.configure_flit()
  require("flit").setup({
    keys = { f = "f", F = "F", t = "t", T = "T" },
    labeled_modes = "nvo",
    multiline = false,
    opts = {},
  })
end

function manager.configure_lspsaga()
  require("custom.config.plugin.lspsaga")
end

function manager.configure_telescope()
  local actions = require("telescope.actions")
  local layout = require("telescope.actions.layout")
  return {
    extensions_list = {
      "projects",
      "themes",
    },
    defaults = {
      mappings = {
        n = {
          ['<C-p>'] = layout.toggle_preview,
          ["<C-d>"] = actions.delete_buffer,
        },
      },
    },
  }
end

function manager.configure_nvterm()
  return {
    terminals = {
      type_opts = {
        float = {
          relative = 'editor',
          row = 0.1,
          col = 0.1,
          width = 0.8,
          height = 0.75,
          border = "single",
        },
        horizontal = { location = "rightbelow", split_ratio = .2, },
        vertical = { location = "rightbelow", split_ratio = .2 },
      }
    }
  }
end

function manager.configure_alpha()
  require("custom.config.plugin.alpha")
end

function manager.configure_tmux_navigation()
  return require("nvim-tmux-navigation").setup({
    disable_when_zoomed = true,
    keybindings = {
      left = "<C-h>",
      down = "<C-j>",
      up = "<C-k>",
      right = "<C-l>",
      last_active = "<C-\\>",
      next = "<C-Space>",
    }
  })
end

function manager.configure_mini_animate()
  require("mini.animate").setup()
end

return manager
