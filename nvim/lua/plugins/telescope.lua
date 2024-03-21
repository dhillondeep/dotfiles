return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  opts = function()
    local layout = require("telescope.actions.layout")
    local actions = require("telescope.actions")
    return {
      defaults = {
        mappings = {
          n = {
            ["<C-p>"] = layout.toggle_preview,
            ["<C-d>"] = actions.delete_buffer,
          },
        },
      },
    }
  end,
}
