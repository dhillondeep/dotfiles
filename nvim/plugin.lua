local plugin_manager = require("custom.config.plugin.manager")

local plugins = {
  --- File Manager & Search/Find
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      local default = require("plugins.configs.nvimtree")
      return vim.tbl_deep_extend("force", default, plugin_manager.get_nvim_tree_opts())
    end,
  },

  {
    "ibhagwan/fzf-lua",
    init = require("core.utils").load_mappings("fzflua"),
    cmd = { "FzfLua" },
    dependencies = {
      {
        "junegunn/fzf",
        build = "./install --all",
      },
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      plugin_manager.configure_fzflua()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "olimorris/persisted.nvim",
      "ahmedkhalf/project.nvim",
    },
    opts = function()
      local default = require("plugins.configs.telescope")
      return vim.tbl_deep_extend("force", default, plugin_manager.configure_telescope())
    end
  },

  --- LSP & Code
  {
    "folke/neodev.nvim",
  },

  {
    "glepnir/lspsaga.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    event = "LspAttach",
    init = require("core.utils").load_mappings("lspsaga"),
    config = function()
      plugin_manager.configure_lspsaga()
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = function()
      local opts = require("plugins.configs.mason")
      return vim.tbl_deep_extend("force", opts, plugin_manager.get_mason_opts())
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "MasonInstallAll", "LspInstall", "LspUninstall" },
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      plugin_manager.configure_mason_lspconfig()
    end,
  },

  { "jose-elias-alvarez/null-ls.nvim" },

  { "b0o/SchemaStore.nvim" },

  {
    "neovim/nvim-lspconfig",
    config = function()
      plugin_manager.configure_lspconfig()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "p00f/nvim-ts-rainbow" },
    },
    opts = function()
      local default = require("plugins.configs.treesitter")
      return vim.tbl_deep_extend("force", default, plugin_manager.get_treesitter_opts())
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local default = require("plugins.configs.cmp")
      return vim.tbl_deep_extend("force", default, plugin_manager.get_nvimcmp_opts())
    end
  },

  --- Startup, Sessions, and Projects ---
  {
    "olimorris/persisted.nvim",
    lazy = false,
    config = function()
      plugin_manager.configure_persisted()
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      plugin_manager.configure_project()
    end,
  },

  --- Copy, Paste and Move ---

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = { "<C-l>", "<C-h>", "<C-j>", "<C-k>" },
    init = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },

  {
    "christoomey/vim-system-copy",
    dependencies = {
      {
        "ojroques/vim-oscyank",
        init = function()
          vim.g.oscyank_silent = true
          vim.g.oscyank_term = "default"
        end,
      },
    },
    keys = { "cp", "cP" }, -- only load for these keys: copy supported
    init = function()
      vim.g.system_copy_silent = 1
      vim.g.system_copy_enable_osc52 = 1
    end,
  },

  {
    "ggandor/leap.nvim",
    keys = { "s", "S" },
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    "ggandor/flit.nvim",
    dependencies = { "leap.nvim" },
    keys = { "f", "F", "t", "T" },
    config = function()
      plugin_manager.configure_flit()
    end,
  },

  --- UI/Look and feel ---

  {
    "nmac427/guess-indent.nvim",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = function()
      plugin_manager.configure_guess_indent()
    end,
  },

  --- Terminal ---

  -- Manage multiple terminal windows
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    init = require("core.utils").load_mappings("toggleterm"),
    config = function()
      plugin_manager.configure_toggleterm()
    end,
  },
}

return plugins
