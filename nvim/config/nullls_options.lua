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
  ["fixjson"] = function()
    return nulllls_builtins().formatting.fixjson
  end,
  ["shfmt"] = function()
    return nulllls_builtins().formatting.shfmt
  end,
  -- diagnostics --
  ["flake8"] = function()
    return nulllls_builtins().diagnostics.flake8
  end,
}
