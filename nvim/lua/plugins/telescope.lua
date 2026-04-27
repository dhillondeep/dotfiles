return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  opts = function(_, opts)
    local layout = require("telescope.actions.layout")
    local actions = require("telescope.actions")

    opts.defaults = opts.defaults or {}
    opts.defaults.mappings = opts.defaults.mappings or {}
    opts.defaults.mappings.n = opts.defaults.mappings.n or {}

    local n_mapping = opts.defaults.mappings.n
    n_mapping["<C-p>"] = layout.toggle_preview
    n_mapping["<C-d>"] = actions.delete_buffer
  end,
}
