-- n, v, i, t = mode names

local M = {}

M.disabled = {
  n = {
    ["<leader>n"] = "",  -- [general] toggle numbers
    ["<leader>rn"] = "", -- [general] toggle relative number
    ["<leader>ra"] = "", -- [lspconfig] lsp rename: replaced with <leader>rn
  }
}

M.general = {
  n = {
    ["<leader>w"] = { "<cmd> w <CR>", "save file" },
    ["<C-q>"] = { "<cmd> q <CR>", "close file" },
    ["<leader>cb"] = { function()
      local curbufnr = vim.api.nvim_get_current_buf()
      local buflist = vim.api.nvim_list_bufs()
      for _, bufnr in ipairs(buflist) do
        if vim.bo[bufnr].buflisted and bufnr ~= curbufnr and (vim.fn.getbufvar(bufnr, 'bufpersist') ~= 1) then
          vim.cmd('bd ' .. tostring(bufnr))
        end
      end
    end, "close buffers" },
  },
}

M.lspsaga = {
  plugin = true,
  n = {
    ["gf"] = { "<cmd>Lspsaga lsp_finder<CR>", "lsp finder" },
    ["gp"] = { "<cmd>Lspsaga peek_definition<CR>", "lsp peek definition" },
    ["gt"] = { "<cmd>Lspsaga peek_type_definition<CR>", "lsp peek type definition" },
    ["<leader>la"] = { "<cmd> Lspsaga code_action<CR>", "lsp code action" },
    ["[e"] = {
      function()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end,
      "lsp diagnostic jump prev",
    },
    ["]e"] = {
      function()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
      end,
      "lsp diagnostic jump next",
    },
  },
}

M.lspconfig = {
  plugin = true,
  n = {
    ["<leader>fm"] = { "<cmd> Format <CR>", "lsp formatting" },
    ["<leader>rn"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },
  },
}

M.navbuddy = {
  plugin = true,
  n = {
    ["<leader>fn"] = { "<cmd>Navbuddy<CR>", "show navbuddy" },
  },
}

M.fzflua = {
  plugin = true,
  n = {
    ["<leader>fw"] = { "<cmd> FzfLua live_grep_native <CR>", "live grep" },
    ["<leader>fl"] = { "<cmd> FzfLua blines <CR>", "find lines in buffer" },
    ["<leader>f;"] = { "<cmd> FzfLua lines <CR>", "find lines in all buffers" },
    ["<leader>fr"] = { "<cmd> FzfLua resume <CR>", "resume last fzf-lua command" },
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
    ["<leader>fp"] = { "<cmd> Telescope projects <CR>", "find projects" },
    ["<leader>fs"] = { "<cmd> Telescope persisted <CR>", "find sessions" }
  },
}

M.nvterm = {
  t = {
    ["<C-h>"] = { "<C-\\><C-n><C-w>h", "Terminal move left" },
    ["<C-l>"] = { "<C-\\><C-n><C-w>l", "Terminal move right" },
    ["<C-j>"] = { "<C-\\><C-n><C-w>j", "Terminal move down" },
    ["<C-k>"] = { "<C-\\><C-n><C-w>k", "Terminal move up" },
    ["<leader><esc>"] = { "<C-\\><C-n>", "Toggleterm change to normal mode" },
  },
  n = {
    -- toggle in normal mode
    ["<leader>tf"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<leader>th"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<leader>tv"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
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
