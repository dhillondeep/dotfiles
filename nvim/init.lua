-- global configuration
_G.deepvim = {}

-- load global configuration
require("custom.config.constants")
require("custom.config.options")
require("custom.config.config")
require("custom.utils")

-- Set vim options with a nested table like API with the format vim.<first_key>.<second_key>.<value>
for scope, table in pairs(deepvim.vim_opts) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end

-- Disable comment-continuation
vim.cmd([[
  autocmd FileType * set formatoptions-=cro
]])

-- Start from the same line when left
vim.cmd([[
  if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
  endif
  " when editing a file, always jump to the last known cursor position.
	" don't do it when the position is invalid or when inside an event handler
	autocmd BufReadPost *
		\ if &ft !~# 'commit' && ! &diff &&
		\      line("'\"") >= 1 && line("'\"") <= line("$")
		\|   execute 'normal! g`"zvzz'
		\| endif
]])

-- Highlight yanks
vim.cmd([[
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup END
]])

-- Automatically set read-only for files being edited elsewhere
vim.cmd([[
  " automatically set read-only for files being edited elsewhere
	autocmd SwapExists * nested let v:swapchoice = 'o'
]])

-- Store buffers that are not edited or used
local id = vim.api.nvim_create_augroup("startup", {
  clear = false
})

local persistbuffer = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.fn.setbufvar(bufnr, 'bufpersist', 1)
end

vim.api.nvim_create_autocmd({"BufRead"}, {
  group = id,
  pattern = {"*"},
  callback = function()
    vim.api.nvim_create_autocmd({"InsertEnter","BufModifiedSet"}, {
      buffer = 0,
      once = true,
      callback = function()
        persistbuffer()
      end
    })
  end
})
