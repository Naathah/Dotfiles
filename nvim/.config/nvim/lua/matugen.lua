 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#141313',
    base01 = '#201f20',
    base02 = '#2a2a2a',
    base03 = '#909095',
    base04 = '#c6c6cb',
    base05 = '#e5e2e1',
    base06 = '#e5e2e1',
    base07 = '#e5e2e1',
    base08 = '#ffb4ab',
    base09 = '#cec4c9',
    base0A = '#c7c6c8',
    base0B = '#c6c6cb',
    base0C = '#cec4c9',
    base0D = '#c6c6cb',
    base0E = '#c7c6c8',
    base0F = '#e4e2e4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e5e2e1',          bg = '#141313' })
  hi('TelescopeBorder',         { fg = '#909095',             bg = '#141313' })
  hi('TelescopePromptNormal',   { fg = '#e5e2e1',          bg = '#141313' })
  hi('TelescopePromptBorder',   { fg = '#909095',             bg = '#141313' })
  hi('TelescopePromptPrefix',   { fg = '#c6c6cb',             bg = '#141313' })
  hi('TelescopePromptCounter',  { fg = '#c6c6cb',  bg = '#141313' })
  hi('TelescopePromptTitle',    { fg = '#141313',             bg = '#c6c6cb' })
  hi('TelescopePreviewTitle',   { fg = '#141313',             bg = '#c7c6c8' })
  hi('TelescopeResultsTitle',   { fg = '#141313',             bg = '#cec4c9' })
  hi('TelescopeSelection',      { fg = '#e5e2e1',          bg = '#2a2a2a' })
  hi('TelescopeSelectionCaret', { fg = '#c6c6cb',             bg = '#2a2a2a' })
  hi('TelescopeMatching',       { fg = '#c6c6cb',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e5e2e1',          bg = '#141313' })
  hi('MiniPickBorder',         { fg = '#909095',             bg = '#141313' })
  hi('MiniPickPrompt',   { fg = '#e5e2e1',          bg = '#141313' })
  hi('MiniPickPromptPrefix',   { fg = '#c6c6cb',             bg = '#141313' })
  hi('MiniPickBorderText',    { fg = '#141313',             bg = '#c6c6cb' })
  hi('MiniPickMatchCurrent',      { fg = '#e5e2e1',          bg = '#2a2a2a' })
  hi('MiniPickPromptCaret', { fg = '#c6c6cb',             bg = '#2a2a2a' })
  hi('MiniPickMatchRanges',       { fg = '#c6c6cb',             bold = true })
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
