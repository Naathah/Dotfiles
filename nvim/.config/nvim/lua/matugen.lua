 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#131313',
    base01 = '#20201f',
    base02 = '#2a2a29',
    base03 = '#8f928b',
    base04 = '#c5c7c0',
    base05 = '#e5e2e0',
    base06 = '#e5e2e0',
    base07 = '#e5e2e0',
    base08 = '#ffb4ab',
    base09 = '#c0c8ca',
    base0A = '#c6c7c2',
    base0B = '#c3c8be',
    base0C = '#c0c8ca',
    base0D = '#c3c8be',
    base0E = '#c6c7c2',
    base0F = '#e3e3dd',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e5e2e0',          bg = '#131313' })
  hi('TelescopeBorder',         { fg = '#8f928b',             bg = '#131313' })
  hi('TelescopePromptNormal',   { fg = '#e5e2e0',          bg = '#131313' })
  hi('TelescopePromptBorder',   { fg = '#8f928b',             bg = '#131313' })
  hi('TelescopePromptPrefix',   { fg = '#c3c8be',             bg = '#131313' })
  hi('TelescopePromptCounter',  { fg = '#c5c7c0',  bg = '#131313' })
  hi('TelescopePromptTitle',    { fg = '#131313',             bg = '#c3c8be' })
  hi('TelescopePreviewTitle',   { fg = '#131313',             bg = '#c6c7c2' })
  hi('TelescopeResultsTitle',   { fg = '#131313',             bg = '#c0c8ca' })
  hi('TelescopeSelection',      { fg = '#e5e2e0',          bg = '#2a2a29' })
  hi('TelescopeSelectionCaret', { fg = '#c3c8be',             bg = '#2a2a29' })
  hi('TelescopeMatching',       { fg = '#c3c8be',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e5e2e0',          bg = '#131313' })
  hi('MiniPickBorder',         { fg = '#8f928b',             bg = '#131313' })
  hi('MiniPickPrompt',   { fg = '#e5e2e0',          bg = '#131313' })
  hi('MiniPickPromptPrefix',   { fg = '#c3c8be',             bg = '#131313' })
  hi('MiniPickBorderText',    { fg = '#131313',             bg = '#c3c8be' })
  hi('MiniPickMatchCurrent',      { fg = '#e5e2e0',          bg = '#2a2a29' })
  hi('MiniPickPromptCaret', { fg = '#c3c8be',             bg = '#2a2a29' })
  hi('MiniPickMatchRanges',       { fg = '#c3c8be',             bold = true })
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
