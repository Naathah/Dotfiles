 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#121316',
    base01 = '#1e2022',
    base02 = '#282a2c',
    base03 = '#8c9198',
    base04 = '#c2c7ce',
    base05 = '#e2e2e5',
    base06 = '#e2e2e5',
    base07 = '#e2e2e5',
    base08 = '#ffb4ab',
    base09 = '#e1b9e6',
    base0A = '#bbc8d7',
    base0B = '#a7caed',
    base0C = '#e1b9e6',
    base0D = '#a7caed',
    base0E = '#bbc8d7',
    base0F = '#d7e4f4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e2e2e5',          bg = '#121316' })
  hi('TelescopeBorder',         { fg = '#8c9198',             bg = '#121316' })
  hi('TelescopePromptNormal',   { fg = '#e2e2e5',          bg = '#121316' })
  hi('TelescopePromptBorder',   { fg = '#8c9198',             bg = '#121316' })
  hi('TelescopePromptPrefix',   { fg = '#a7caed',             bg = '#121316' })
  hi('TelescopePromptCounter',  { fg = '#c2c7ce',  bg = '#121316' })
  hi('TelescopePromptTitle',    { fg = '#121316',             bg = '#a7caed' })
  hi('TelescopePreviewTitle',   { fg = '#121316',             bg = '#bbc8d7' })
  hi('TelescopeResultsTitle',   { fg = '#121316',             bg = '#e1b9e6' })
  hi('TelescopeSelection',      { fg = '#e2e2e5',          bg = '#282a2c' })
  hi('TelescopeSelectionCaret', { fg = '#a7caed',             bg = '#282a2c' })
  hi('TelescopeMatching',       { fg = '#a7caed',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e2e2e5',          bg = '#121316' })
  hi('MiniPickBorder',         { fg = '#8c9198',             bg = '#121316' })
  hi('MiniPickPrompt',   { fg = '#e2e2e5',          bg = '#121316' })
  hi('MiniPickPromptPrefix',   { fg = '#a7caed',             bg = '#121316' })
  hi('MiniPickBorderText',    { fg = '#121316',             bg = '#a7caed' })
  hi('MiniPickMatchCurrent',      { fg = '#e2e2e5',          bg = '#282a2c' })
  hi('MiniPickPromptCaret', { fg = '#a7caed',             bg = '#282a2c' })
  hi('MiniPickMatchRanges',       { fg = '#a7caed',             bold = true })
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
