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
    -- quit
    ["<C-q>"] = { "<cmd> q <CR>", "close file" },
    ["<leader>kb"] = { function()
      local curbufnr = vim.api.nvim_get_current_buf()
      local buflist = vim.api.nvim_list_bufs()
      for _, bufnr in ipairs(buflist) do
        if vim.bo[bufnr].buflisted and bufnr ~= curbufnr and (vim.fn.getbufvar(bufnr, 'bufpersist') ~= 1) then
          vim.cmd('bd ' .. tostring(bufnr))
        end
      end
    end, "kill buffers" },
  },
}

M.lspsaga = {
  plugin = true,
  n = {
    ["gf"] = { "<cmd>Lspsaga lsp_finder<CR>", "lsp finder" },
    ["gp"] = { "<cmd>Lspsaga peek_definition<CR>", "lsp peek definition" },
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

-- Toggleterm
M.toggleterm = {
  t = {
    ["<C-h>"] = { "<C-\\><C-n><C-w>h", "ToggleTerm move left" },
    ["<C-l>"] = { "<C-\\><C-n><C-w>l", "ToggleTerm move right" },
    ["<C-j>"] = { "<C-\\><C-n><C-w>j", "ToggleTerm move down" },
    ["<C-k>"] = { "<C-\\><C-n><C-w>k", "ToggleTerm move up" },
    ["<leader><esc>"] = { "<C-\\><C-n>", "Toggleterm change to normal mode" },
  },

  n = {
    ["<leader>tl"] = {
      function()
        deepvim.fn.toggle_term("lazygit")
      end,
      "ToggleTerm lazygit",
    },
    ["<leader>tv"] = {
      function()
        deepvim.fn.toggle_term({direction="vertical"})
      end,
      "ToggleTerm vertical",
    },
    ["<leader>tcv"] = {
      function()
        deepvim.fn.close_term({direction="vertical"})
      end,
      "ToggleTerm close vertical",
    },
    ["<leader>th"] = {
      function()
        deepvim.fn.toggle_term({direction="horizontal"})
      end,
      "ToggleTerm horizontal",
    },
    ["<leader>tch"] = {
      function()
        deepvim.fn.close_term({direction="horizontal"})
      end,
      "ToggleTerm close horizontal",
    },
    ["<leader>tf"] = {
      function()
        deepvim.fn.toggle_term({direction="float"})
      end,
      "ToggleTerm float",
    },
    ["<leader>tcf"] = {
      function()
        deepvim.fn.close_term({direction="float"})
      end,
      "ToggleTerm close float",
    },
    ["<leader>tca"] = {
      function()
        deepvim.fn.close_all_terms()
      end,
      "ToggleTerm close all",
    },
  },
}


return M
