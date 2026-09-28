 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#121316',
    base01 = '#1e2022',
    base02 = '#282a2d',
    base03 = '#8c9199',
    base04 = '#c2c7cf',
    base05 = '#e2e2e6',
    base06 = '#e2e2e6',
    base07 = '#e2e2e6',
    base08 = '#ffb4ab',
    base09 = '#e4b8ed',
    base0A = '#b9c8db',
    base0B = '#a2caf7',
    base0C = '#e4b8ed',
    base0D = '#a2caf7',
    base0E = '#b9c8db',
    base0F = '#d5e4f8',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e2e2e6',          bg = '#121316' })
  hi('TelescopeBorder',         { fg = '#8c9199',             bg = '#121316' })
  hi('TelescopePromptNormal',   { fg = '#e2e2e6',          bg = '#121316' })
  hi('TelescopePromptBorder',   { fg = '#8c9199',             bg = '#121316' })
  hi('TelescopePromptPrefix',   { fg = '#a2caf7',             bg = '#121316' })
  hi('TelescopePromptCounter',  { fg = '#c2c7cf',  bg = '#121316' })
  hi('TelescopePromptTitle',    { fg = '#121316',             bg = '#a2caf7' })
  hi('TelescopePreviewTitle',   { fg = '#121316',             bg = '#b9c8db' })
  hi('TelescopeResultsTitle',   { fg = '#121316',             bg = '#e4b8ed' })
  hi('TelescopeSelection',      { fg = '#e2e2e6',          bg = '#282a2d' })
  hi('TelescopeSelectionCaret', { fg = '#a2caf7',             bg = '#282a2d' })
  hi('TelescopeMatching',       { fg = '#a2caf7',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e2e2e6',          bg = '#121316' })
  hi('MiniPickBorder',         { fg = '#8c9199',             bg = '#121316' })
  hi('MiniPickPrompt',   { fg = '#e2e2e6',          bg = '#121316' })
  hi('MiniPickPromptPrefix',   { fg = '#a2caf7',             bg = '#121316' })
  hi('MiniPickBorderText',    { fg = '#121316',             bg = '#a2caf7' })
  hi('MiniPickMatchCurrent',      { fg = '#e2e2e6',          bg = '#282a2d' })
  hi('MiniPickPromptCaret', { fg = '#a2caf7',             bg = '#282a2d' })
  hi('MiniPickMatchRanges',       { fg = '#a2caf7',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
