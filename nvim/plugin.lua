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
			return vim.tbl_deep_extend("force", default, require("custom.config.plugin.cmp"))
		end
	},

	--- Startup, Sessions, and Projects ---
	{
		"Shatur/neovim-session-manager",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local Path = require('plenary.path')
			local config = require('session_manager.config')
			require('session_manager').setup({
				sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),
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
		'echasnovski/mini.animate',
		lazy = false,
		version = false,
		config = function()
			plugin_manager.configure_mini_animate()
		end,
	},

	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		opts = {
			bottom = {
				{
					ft = "terminal",
					size = { height = 0.2 },
					filter = function(buf, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
			},
			left = {
				{
					title = "Files",
					ft = "NvimTree",
					pinned = true,
					size = { height = 0.6, width = 0.1 },
				},
				{
					title = "Outline",
					ft = "aerial",
					pinned = true,
					size = { height = 0.4, width = 0, 1 },
				},
			},
		}
	},

	{
		'stevearc/dressing.nvim',
		lazy = false,
		opts = {},
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

	{
		'stevearc/aerial.nvim',
		cmd = "AerialToggle",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
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
