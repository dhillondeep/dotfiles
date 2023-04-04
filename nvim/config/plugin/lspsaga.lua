require("lspsaga").setup({
  ui = {
    border = "rounded",
  },
  symbol_in_winbar = {
    enable = false,
  },
  beacon = {
    enable = true,
    frequency = 20,
  },
  definition = {
    edit = "<CR>",
    vsplit = "<C-v>",
    split = "<C-s>",
    tabe = "<C-t>",
    quit = "<ESC>",
  },
  finder = {
    keys = {
      jump_to = "<CR>",
      expand_or_jump = "<CR>",
      vsplit = "<C-v>",
      split = "<C-s>",
      tabe = "<C-t>",
      tabnew = "r",
      quit = { "q", "<ESC>" },
    },
  },
  code_action = {
    keys = {
      quit = "<ESC>",
      exec = "<CR>",
    },
  },
  rename = {
    quit = "<ESC>",
    exec = "<CR>",
    confirm = "<CR>",
  },
  lightbulb = {
    enable = true,
    enable_in_insert = false,
    sign = false,
    sign_priority = 20,
    virtual_text = false,
  },
})

-- set custom highlights

-- TODO: fix color scheme and spend some time

local colors = require("base46").get_theme_tb("base_30")
deepvim.cfg.set_highlights(require("base46"))
local highlights = {
  -- generic
  SagaBeacon = { bg = colors.white },
  SagaBorder = { link = "DeepNvimBorder" },
  -- code action
  LspSagaCodeActionTitle = { link = "DeepNvimTitle" },
  LspSagaCodeActionBorder = { link = "DeepNvimBorder" },
  LspSagaCodeActionContent = { link = "DeepNvimContent" },
  CodeActionNumber = { link = 'DeepNvimTitle' },
  -- finder
  FinderSelection = { link = 'String' },
  FinderFName = {},
  FinderCode = { link = 'Comment' },
  FinderCount = { link = 'Constant' },
  FinderIcon = { link = 'Type' },
  FinderType = { link = "DeepNvimTitle" },
  FinderStart = { link = 'Function' },
  LspSagaAutoPreview = { link = "DeepNvimBorder" },
  LspSagaFinderSelection = { link = "DeepNvimSelection" },
  FinderParam = { link = "DeepNvimTitle" },
  DefinitionsIcon = { link = "DeepNvimTitleAlt" },
  Definitions = { link = "DeepNvimTitleAlt" },
  DefinitionCount = { fg = colors.white },
  ReferencesIcon = { link = "DeepNvimTitleAlt" },
  References = { link = "DeepNvimTitleAlt" },
  ReferencesCount = { fg = colors.white },
  ImplementsIcon = { link = "DeepNvimTitleAlt" },
  Implements = { link = "DeepNvimTitleAlt" },
  ImplementsCount = { fg = colors.white },
  --finder spinner
  FinderSpinnerBorder = { link = "DeepNvimBorder" },
  FinderSpinnerTitle = { link = "DeepNvimTitle" },
  FinderSpinner = { link = "DeepNvimTitleAlt" },
  FinderPreviewSearch = { link = "Search" },
  -- hover
  LspSagaHoverBorder = { link = "DeepNvimBorder" },
  LspSagaHoverTrunCateLine = { link = "LspSagaHoverBorder" },
  -- diagnostic
  DiagnosticQuickFix = { link = "DeepNvimTitleAlt" },
  DiagnosticMap = { fg = colors.white },
  DiagnosticLineCol = { fg = colors.white },
  LspSagaDiagnosticTruncateLine = { link = "LspSagaDiagnosticBorder" },
  ColInLineDiagnostic = { link = "DeepNvimBorder" },
}

for group, conf in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, conf)
end
