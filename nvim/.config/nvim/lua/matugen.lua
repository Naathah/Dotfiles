 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#131314',
    base01 = '#1f2021',
    base02 = '#292a2b',
    base03 = '#8d9196',
    base04 = '#c3c7cb',
    base05 = '#e4e2e3',
    base06 = '#e4e2e3',
    base07 = '#e4e2e3',
    base08 = '#ffb4ab',
    base09 = '#d6c0d6',
    base0A = '#c1c7ce',
    base0B = '#b6c9d9',
    base0C = '#d6c0d6',
    base0D = '#b6c9d9',
    base0E = '#c1c7ce',
    base0F = '#dde3ea',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e4e2e3',          bg = '#131314' })
  hi('TelescopeBorder',         { fg = '#8d9196',             bg = '#131314' })
  hi('TelescopePromptNormal',   { fg = '#e4e2e3',          bg = '#131314' })
  hi('TelescopePromptBorder',   { fg = '#8d9196',             bg = '#131314' })
  hi('TelescopePromptPrefix',   { fg = '#b6c9d9',             bg = '#131314' })
  hi('TelescopePromptCounter',  { fg = '#c3c7cb',  bg = '#131314' })
  hi('TelescopePromptTitle',    { fg = '#131314',             bg = '#b6c9d9' })
  hi('TelescopePreviewTitle',   { fg = '#131314',             bg = '#c1c7ce' })
  hi('TelescopeResultsTitle',   { fg = '#131314',             bg = '#d6c0d6' })
  hi('TelescopeSelection',      { fg = '#e4e2e3',          bg = '#292a2b' })
  hi('TelescopeSelectionCaret', { fg = '#b6c9d9',             bg = '#292a2b' })
  hi('TelescopeMatching',       { fg = '#b6c9d9',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e4e2e3',          bg = '#131314' })
  hi('MiniPickBorder',         { fg = '#8d9196',             bg = '#131314' })
  hi('MiniPickPrompt',   { fg = '#e4e2e3',          bg = '#131314' })
  hi('MiniPickPromptPrefix',   { fg = '#b6c9d9',             bg = '#131314' })
  hi('MiniPickBorderText',    { fg = '#131314',             bg = '#b6c9d9' })
  hi('MiniPickMatchCurrent',      { fg = '#e4e2e3',          bg = '#292a2b' })
  hi('MiniPickPromptCaret', { fg = '#b6c9d9',             bg = '#292a2b' })
  hi('MiniPickMatchRanges',       { fg = '#b6c9d9',             bold = true })
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
