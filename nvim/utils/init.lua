local utils = {}

--- Get string form of a lua table
function utils.dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. utils.dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

---@generic T
---@param callback fun(item: T, index: number): T
---@param list T[]
---@return T[]
function utils.map(callback, list)
  local accum = {}
  for index, item in ipairs(list) do
    accum[index] = callback(item, index)
  end
  return accum
end

utils.path_sep = vim.startswith(vim.loop.os_uname().sysname, "Windows") and "\\" or "/"

--- Converts boolean to string
function utils.bool2str(bool)
  return bool and "on" or "off"
end

--- Merge extended options with a default table of options
function utils.default_tbl(opts, default)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end

deepvim.utils = utils
