-- n, v, i, t = mode names

local M = {}

M.disabled = {
  n = {
    ["<leader>n"] = "",  -- [general] toggle numbers
    ["<leader>rn"] = "", -- [general] toggle relative number
    ["<leader>ra"] = "", -- [lspconfig] lsp rename: replaced with <leader>rn
    ["<tab>"] = "",      -- [tabufline] change buffer next
    ["<S-tab>"] = "",    -- [tabufline] change buffer prev
    ["<C-s>"] = "",

    -- conflict with tmux navigation plugin
    ["<C-h>"] = "",
    ["<C-l>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
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
    ["gr"] = { "<cmd> Lspsaga rename <CR>", "LSP rename" },
    ["gd"] = { "<cmd>Lspsaga goto_definition<CR>", "LSP definition" },
    ["gf"] = { "<cmd>Lspsaga lsp_finder<CR>", "LSP finder" },
    ["gp"] = { "<cmd>Lspsaga peek_definition<CR>", "LSP peek definition" },
    ["gt"] = { "<cmd>Lspsaga peek_type_definition<CR>", "LSP peek type definition" },
    ["ga"] = { "<cmd> Lspsaga code_action<CR>", "LSP code action" },
    ["gi"] = { "<cmd> Lspsaga incoming_calls<CR>", "LSP incoming calls" },
    ["go"] = { "<cmd> Lspsaga outgoing_calls<CR>", "LSP outgoing calls" },
    ["<leader>o"] = { "<cmd> Lspsaga outline<CR>", "LSP code outline" },
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
    ["<leader>fm"] = { "<cmd> Format <CR>", "LSP formatting" },
  },
}

M.fzflua = {
  plugin = true,
  n = {
    ["<leader>fw"] = { "<cmd> FzfLua live_grep_native <CR>", "Live grep" },
    ["<leader>fl"] = { "<cmd> FzfLua blines <CR>", "Find lines in buffer" },
    ["<leader>f;"] = { "<cmd> FzfLua lines <CR>", "Find lines in all buffers" },
    ["<leader>fr"] = { "<cmd> FzfLua resume <CR>", "Resume last fzf-lua command" },
  }
}

M.telescope = {
  n = {
    ["<leader>fb"] = {
      function()
        require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
      end,
      "find buffers"
    },
    ["<leader>fp"] = { "<cmd> Telescope projects <CR>", "Find projects" },
    ["<leader>fs"] = { "<cmd> SessionManager load_session<CR>", "Find sessions" }
  },
}

M.nvterm = {
  t = {
    ["<C-h>"] = { "<C-\\><C-n><C-w>h", "Terminal move left" },
    ["<C-l>"] = { "<C-\\><C-n><C-w>l", "Terminal move right" },
    ["<C-j>"] = { "<C-\\><C-n><C-w>j", "Terminal move down" },
    ["<C-k>"] = { "<C-\\><C-n><C-w>k", "Terminal move up" },
    ["<C-esc>"] = { "<C-\\><C-n>", "Terminal change to normal mode" },
  },
  n = {
    -- toggle in normal mode
    ["<leader>tf"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Terminal toggle floating term",
    },

    ["<leader>tt"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Terminal toggle",
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
      "View git diff",
    },
  },
}

return M
