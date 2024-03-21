--- Options to configure various functionalities and properties ---
-------------------------------------------------------------------

local opts = {
  lsp = {
    servers = { "gopls", "pyright", "ruff_lsp", "lua_ls", "vimls", "jsonls", "bashls" },
  },
  nulls = {
    servers = { "prettierd", "shfmt", "yamllint", "packer" },
  },
  ts = {
    languages = {
      "lua",
      "vim",
      "go",
      "cpp",
      "python",
      "c",
      "bash",
      "json",
      "json5",
      "gomod",
      "gowork",
      "yaml",
      "html",
      "markdown",
      "markdown_inline",
      "hcl",
    },
  },
}

-- vim options
local vim_opts = {
  opt = {
    backspace = vim.opt.backspace + { "nostop" },                -- Don't stop backspace at insert
    clipboard = "",                                              -- Disable system clipboard
    completeopt = { "menu", "menuone", "noinsert", "noselect" }, -- Options for insert mode completion
    -- copyindent = true, -- Copy the previous indentation on autoindenting
    --   cursorline = true, -- Highlight the text line of the cursor
    expandtab = true, -- Enable the use of space in tab
    --   fileencoding = "utf-8", -- File content encoding for the buffer
    --   fillchars = { eob = " " }, -- Disable `~` on nonexistent lines
    --   history = 100, -- Number of commands to remember in a history table
    ignorecase = true, -- Case insensitive searching
    laststatus = 3,    -- globalstatus
    splitkeep = "screen",
    mouse = "",        -- Enable mouse support in normal and visual mode
    number = true,     -- Show numberline
    --   preserveindent = true, -- Preserve indent structure as much as possible
    --   pumheight = 10, -- Height of the pop up menu
    relativenumber = true, -- Show relative numberline
    scrolloff = 2,         -- Number of lines to keep above and below the cursor
    -- shiftwidth = 2, -- Number of space inserted for indentation
    --   shortmess = vim.opt.shortmess + { s = true, I = true },
    --   showmode = false, -- Disable showing modes in command line
    -- showtabline = 2, -- always display tabline
    sidescrolloff = 8, -- Number of columns to keep at the sides of the cursor
    --   signcolumn = "yes", -- Always show the sign column
    --   smartcase = true, -- Case sensitivie searching
    splitbelow = true, -- Splitting a new window below the current one
    splitright = true, -- Splitting a new window at the right of the current one
    --   tabstop = 2, -- Number of space in a tab
    --   termguicolors = true, -- Enable 24-bit RGB color in the TUI
    timeoutlen = 400, -- Length of time to wait for a mapped sequence
    undofile = true,  -- Enable persistent undo
    --   updatetime = 300, -- Length of time to wait before triggering the plugin
    --   wrap = false, -- Disable wrapping of lines longer than the width of window
    --   writebackup = false, -- Disable making a backup before overwriting a file
  },
  g = {
    highlighturl_enabled = true,     -- highlight URLs by default
    zipPlugin = false,               -- disable zip
    load_black = false,              -- disable black
    loaded_2html_plugin = true,      -- disable 2html
    loaded_getscript = true,         -- disable getscript
    loaded_getscriptPlugin = true,   -- disable getscript
    loaded_gzip = true,              -- disable gzip
    loaded_logipat = true,           -- disable logipat
    loaded_matchit = true,           -- disable matchit
    loaded_netrwFileHandlers = true, -- disable netrw
    loaded_netrwPlugin = true,       -- disable netrw
    loaded_netrwSettngs = true,      -- disable netrw
    loaded_remote_plugins = true,    -- disable remote plugins
    loaded_tar = true,               -- disable tar
    loaded_tarPlugin = true,         -- disable tar
    loaded_zip = true,               -- disable zip
    loaded_zipPlugin = true,         -- disable zip
    loaded_vimball = true,           -- disable vimball
    loaded_vimballPlugin = true,     -- disable vimball
  },
}

deepvim.opts = opts
deepvim.vim_opts = vim_opts