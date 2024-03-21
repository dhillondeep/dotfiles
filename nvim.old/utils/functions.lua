local g = {
  user_terminals = {},
}

local fn = {}

local function create_term_opts(opts)
	if type(opts) == "string" then
		opts = { cmd = opts }
	elseif opts == nil then
		opts = {}
	end
	opts.hidden = true

	return opts
end

function fn.close_all_terms()
	local terms = g.user_terminals

	for k, _ in pairs(terms) do
		for n, _ in pairs(terms[k]) do
			local term = terms[k][n]
			term:shutdown()
		end
	end

	g.user_terminals = {}
end

function fn.close_term(opts)
	local terms = g.user_terminals

	local num = vim.v.count > 0 and vim.v.count or 1
	opts = create_term_opts(opts)

	local key = deepvim.utils.dump(opts)
	if terms[key] ~= nil and terms[key][num] ~= nil then
		local term = terms[key][num]
		term:shutdown()
		table.remove(terms[key], num)
	end
end

function fn.toggle_term(opts)
	local terms = g.user_terminals

	local num = vim.v.count > 0 and vim.v.count or 1
	opts = create_term_opts(opts)

	local key = deepvim.utils.dump(opts)
	if not terms[key] then
		terms[key] = {}
	end
	if not terms[key][num] then
		if opts.count == nil or opts.count <= 0 then
			opts.count = vim.tbl_count(terms) * 100 + num
		end
		terms[key][num] = require("toggleterm.terminal").Terminal:new(opts)
	end
	terms[key][num]:toggle()
end

deepvim.fn = fn
