local nulllls_builtins = function()
  return require("null-ls").builtins
end

return {
  -- formatting --
  ["black"] = function()
    return nulllls_builtins().formatting.black
  end,
  ["isort"] = function()
    return nulllls_builtins().formatting.isort
  end,
  ["prettierd"] = function()
    return nulllls_builtins().formatting.prettierd
  end,
  ["shfmt"] = function()
    return nulllls_builtins().formatting.shfmt
  end,
  -- diagnostics --
  ["ruff"] = function()
    return nulllls_builtins().diagnostics.ruff
  end,
  ["yamllint"] = function()
    return nulllls_builtins().diagnostics.yamllint
  end
}
