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
  require("mini.animate").setup({
    resize = {
      enable = false,
    },
  })
end

function manager.get_flash_opts()
  return {
    search = {
      exclude = {
        "notify",
        "noice",
        "cmp_menu",
        function(win)
          -- exclude non-focusable windows
          return not vim.api.nvim_win_get_config(win).focusable
        end,
      },
    },
    modes = {
      char = {
        enabled = false,
      },
    },
  }
end

function manager.configure_neovim_session_manager()
  local path = require('plenary.path')
  local config = require('session_manager.config')
  require('session_manager').setup({
    sessions_dir = path:new(vim.fn.stdpath('data'), 'sessions'),
    autoload_mode = config.AutoloadMode.Disabled,
    autosave_last_session = true,
    autosave_ignore_not_normal = true,
    autosave_ignore_filetypes = {
      'gitcommit',
      'gitrebase',
      "NvimTree",
      "terminal",
    },
  })
end

function manager.get_cmp_opts()
  return require("custom.config.plugin.cmp")
end

function manager.configure_mini_files()
  require("mini.files").setup({
    mappings = {
      go_in       = 'L',
      go_in_plus  = 'l',
      go_out      = 'H',
      go_out_plus = 'h',
    },
  })

  -- Change title highlight
  vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { link = "DeepNvimTitleBg" })
  vim.api.nvim_set_hl(0, "MiniFilesTitle", { link = "DeepNvimTitleAltBg" })

  -- Toggle dotfiles
  local show_dotfiles = true
  local filter_show = function(_) return true end
  local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, '.')
  end
  local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = new_filter } })
  end
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id
      -- Tweak left-hand side of mapping to your liking
      vim.keymap.set('n', '.', toggle_dotfiles, { buffer = buf_id })
    end,
  })

  -- Split mappings
  local map_split = function(buf_id, lhs, direction)
    local rhs = function()
      -- Make new window and set it as target
      local new_target_window
      vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
        vim.cmd(direction .. ' split')
        new_target_window = vim.api.nvim_get_current_win()
      end)
      MiniFiles.set_target_window(new_target_window)
      MiniFiles.go_in()
    end
    -- Adding `desc` will result into `show_help` entries
    local desc = 'Split ' .. direction
    vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
  end
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id
      -- Tweak keys to your liking
      map_split(buf_id, 'gs', 'belowright horizontal')
      map_split(buf_id, 'gv', 'belowright vertical')
    end,
  })
end

function manager.configure_hardtime()
  require("hardtime").setup({
    resetting_keys = {
      ["1"] = { "n", "x" },
      ["2"] = { "n", "x" },
      ["3"] = { "n", "x" },
      ["4"] = { "n", "x" },
      ["5"] = { "n", "x" },
      ["6"] = { "n", "x" },
      ["7"] = { "n", "x" },
      ["8"] = { "n", "x" },
      ["9"] = { "n", "x" },
      ["C"] = { "n" },
      ["d"] = { "n" },
      ["x"] = { "n" },
      ["X"] = { "n" },
      ["y"] = { "n" },
      ["Y"] = { "n" },
      ["p"] = { "n" },
      ["P"] = { "n" },
    },
    hint_keys = {
      ["k"] = { "n", "x" },
      ["j"] = { "n", "x" },
      ["^"] = { "n", "x" },
      ["$"] = { "n", "o" },
      ["a"] = { "n", "o" },
      ["i"] = { "n" },
      ["d"] = { "n" },
      ["l"] = { "o" },
    },
    hint_messages = {
      ["k^"] = "Use - instead of k^",
      ["j^"] = "Use + instead of j^",
      ["d$"] = "Use D instead of d$",
      ["$a"] = "Use A instead of $a",
      ["^i"] = "Use I instead of ^i",
    },
  })
end

return manager
