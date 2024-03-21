local nulllls_builtins = function()
  return require("null-ls").builtins
end

return {
  -- formatting --
  ["prettierd"] = function()
    return nulllls_builtins().formatting.prettierd
  end,
  ["shfmt"] = function()
    return nulllls_builtins().formatting.shfmt
  end,
  ["packer"] = function()
    return nulllls_builtins().formatting.packer
  end,
  -- diagnostics --
  ["yamllint"] = function()
    return nulllls_builtins().diagnostics.yamllint.with({
      extra_args = { "-d", "relaxed" },
    })
  end
}
