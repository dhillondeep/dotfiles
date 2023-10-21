local plugin_manager = require("custom.config.plugin.manager")

local plugins = {
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
			"ahmedkhalf/project.nvim",
		},
		opts = function()
			local default = require("plugins.configs.telescope")
			return vim.tbl_deep_extend("force", default, plugin_manager.configure_telescope())
		end
	},

	--- LSP & Code
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

	{ "lukas-reineke/lsp-format.nvim" },

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
		opts = function()
			local default = require("plugins.configs.treesitter")
			return vim.tbl_deep_extend("force", default, plugin_manager.get_treesitter_opts())
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local default = require("plugins.configs.cmp")
			return vim.tbl_deep_extend("force", default, plugin_manager.get_cmp_opts())
		end
	},

	--- Startup, Sessions, and Projects ---
	{
		"Shatur/neovim-session-manager",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			plugin_manager.configure_neovim_session_manager()
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
		"alexghergh/nvim-tmux-navigation",
		lazy = false,
		config = function()
			plugin_manager.configure_tmux_navigation()
		end
	},

	{
		"ggandor/flit.nvim",
		dependencies = { "ggandor/leap.nvim" },
		keys = { "f", "F", "t", "T" },
		config = function()
			plugin_manager.configure_flit()
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = plugin_manager.get_flash_opts(),
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash standalone jump",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Flash remote",
			},
		},
	},

	--- UI/Look and feel ---

	{
		"NvChad/base46",
		config = function()
			deepvim.cfg.set_highlights(require("base46"))
		end
	},

	{
		'echasnovski/mini.animate',
		lazy = false,
		version = false,
		config = function()
			plugin_manager.configure_mini_animate()
		end,
	},

	{
		'stevearc/dressing.nvim',
		lazy = false,
	},

	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VimEnter",
		config = function()
			plugin_manager.configure_alpha()
		end
	},

	{
		"nmac427/guess-indent.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			plugin_manager.configure_guess_indent()
		end,
	},

	--- Terminal ---
	{
		"NvChad/nvterm",
		opts = function()
			return plugin_manager.configure_nvterm()
		end
	}
}

return plugins
