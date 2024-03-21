return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>fs",
      function()
        require("neo-tree.command").execute({ source = "filesystem" })
      end,
      desc = "Focus NeoTree",
    },
  },
  opts = {
    window = {
      mappings = {
        ["<C-s>"] = "open_split",
        ["<C-v>"] = "open_vsplit",
      },
    },
  },
}
