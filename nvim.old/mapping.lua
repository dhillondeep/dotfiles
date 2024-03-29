-- n, v, i, t = mode names

local M = {}

M.disabled = {
  n = {
    ["<leader>n"] = "",  -- [general] toggle numbers
    ["<leader>rn"] = "", -- [general] toggle relative number
    ["<tab>"] = "",      -- [tabufline] change buffer next
    ["<S-tab>"] = "",    -- [tabufline] change buffer prev
    ["<C-s>"] = "",

    -- conflict with tmux navigation plugin
    ["<C-h>"] = "",
    ["<C-l>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",

    -- telescope
    ["<leader>gt"] = "",
  }
}

M.general = {
  n = {
    ["<leader>w"] = { "<cmd> w <CR>", "Save file" },
    ["<leader>q"] = { "<cmd> q <CR>", "Close file" },
  },
  v = {
    ["y"] = { "ygv<esc>", "Better y" },
  },
}

M.lspsaga = {
  plugin = true,
  n = {
    -- ["<leader>ra"] = { "<cmd> Lspsaga rename <CR>", "LSP rename" },
    ["gd"] = { "<cmd>Lspsaga goto_definition<CR>", "LSP definition" },
    ["gf"] = { "<cmd>Lspsaga finder<CR>", "LSP finder" },
    ["gi"] = { "<cmd> Lspsaga finder imp<CR>", "LSP finder implementation" },
    ["gr"] = { "<cmd> Lspsaga finder ref<CR>", "LSP finder reference" },
    ["gp"] = { "<cmd>Lspsaga peek_definition<CR>", "LSP peek definition" },
    ["gt"] = { "<cmd>Lspsaga peek_type_definition<CR>", "LSP peek type definition" },
    ["ga"] = { "<cmd> Lspsaga code_action<CR>", "LSP code action" },
    ["[e"] = {
      function()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end,
      "LSP diagnostic jump prev",
    },
    ["]e"] = {
      function()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
      end,
      "LSP diagnostic jump next",
    },
  },
}

M.lspconfig = {
  plugin = true,
  n = {
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
  },
}

M.rufflsp = {
  n = {
    ["<leader>fm"] = { "<cmd> RuffFormat <CR>", "LSP formatting" },
  }
}

M.fzflua = {
  plugin = true,
  n = {
    ["<leader>fw"] = { "<cmd> FzfLua live_grep_native <CR>", "Live grep" },
    ["<leader>ff"] = { "<cmd> FzfLua files <CR>", "Find files" },
    ["<leader>fb"] = { "<cmd> FzfLua buffers <CR>", "Find buffers" },
    ["<leader>fz"] = { "<cmd> FzfLua blines <CR>", "Find in current buffer" },
    ["<leader>fa"] = { "<cmd> FzfLua lines <CR>", "Find in all buffers" },
    ["<leader>fo"] = { "<cmd> FzfLua oldfiles <CR>", "Find oldfiles" },
    ["<leader>fr"] = { "<cmd> FzfLua resume <CR>", "Resume last fzf-lua command" },
  }
}

M.telescope = {
  n = {
    ["<leader>fp"] = { "<cmd> Telescope projects <CR>", "Find projects" },
    ["<leader>fs"] = { "<cmd> SessionManager load_session<CR>", "Find sessions" },

    ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "Git status" },
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
  },
}

M.nvterm = {
  t = {
    ["<C-h>"] = { "<C-\\><C-n><C-w>h", "Terminal move left" },
    ["<C-l>"] = { "<C-\\><C-n><C-w>l", "Terminal move right" },
    ["<C-j>"] = { "<C-\\><C-n><C-w>j", "Terminal move down" },
    ["<C-k>"] = { "<C-\\><C-n><C-w>k", "Terminal move up" },
    ["<leader>tf"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Terminal toggle floating term",
    },

    ["<leader>tx"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Terminal toggle horizontal term",
    },

    ["<leader>tv"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Terminal toggle vertical term",
    }
  },
  n = {
    -- toggle in normal mode
    ["<leader>tf"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Terminal toggle floating term",
    },

    ["<leader>tx"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Terminal toggle horizontal term",
    },

    ["<leader>tv"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Terminal toggle vertical term",
    },

    ["<leader>tl"] = {
      function()
        require("nvterm.terminal").send("lazygit", "float")
      end,
      "Terminal toggle lazygit in floating term",
    },
  }
}

M.gitstatus = {
  n = {
    ["<leader>gd"] = {
      function()
        require("gitsigns").diffthis()
      end,
      "Git diff",
    },
  },
}

return M
