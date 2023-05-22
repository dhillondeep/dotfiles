local manager = {
  lspconfig_ft_visited = {},
}

function manager.configure_fzflua()
  require("custom.config.plugin.fzflua")
end

function manager.configure_starter()
  require("custom.config.plugin.starter").setup()
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

function manager.configure_persisted()
  require("persisted").setup({
    silent = false,
    use_git_branch = true,
    autosave = true,
    follow_cwd = true,
    telescope = {
      reset_prompt_after_deletion = true,
    },
  })

  local group = vim.api.nvim_create_augroup("PersistedHooks", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "PersistedSavePre",
    group = group,
    callback = function(_)
      local nvim_tree_present, api = pcall(require, "nvim-tree.api")
      if nvim_tree_present then api.tree.close() end
    end,
  })
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
      "persisted",
      "projects",
      "themes",
    },
    defaults = {
      mappings = {
        i = {
          ['<C-p>'] = layout.toggle_preview
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
    },
  }
end

function manager.configure_toggleterm()
  require("toggleterm").setup {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    highlights = {
      NormalFloat = {
        link = "TelescopeNormal"
      },
      FloatBorder = {
        link = "TelescopeBorder"
      },
    },
    shading_factor = 2,
    direction = "float",
    float_opts = {
      border = "curved",
    },
  }
end

return manager
