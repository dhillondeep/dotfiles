return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
      go = { "gofumpt", "golines", "goimports" },
    },
    formatters = {
      golines = {
        prepend_args = { "--shorten-comments" },
      },
    },
  },
}
