require('vis')

-- ============================================================================
-- OPTIONS
-- ============================================================================
vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    vis:command('set numbers on')          -- Changed from 'number' to 'numbers'
    vis:command('set relativenumbers on')
    vis:command('set tabwidth 2')
    vis:command('set expandtab on')
    vis:command('set autoindent on')
    vis:command('set cursorline off')
    vis:command('set colorcolumn 0')
end)

-- ============================================================================
-- KEYMAPS
-- ============================================================================
vis.events.subscribe(vis.events.INIT, function()
    -- Wrapped line navigation
    vis:map(vis.modes.NORMAL, 'j', 'gj')
    vis:map(vis.modes.NORMAL, 'k', 'gk')

    -- Window splitting
    vis:map(vis.modes.NORMAL, '<Space>sv', ':vsplit<Enter>')
    vis:map(vis.modes.NORMAL, '<Space>sh', ':split<Enter>')

    -- Buffer navigation
    vis:map(vis.modes.NORMAL, '<Space>bn', ':bnext<Enter>')
    vis:map(vis.modes.NORMAL, '<Space>bp', ':bprev<Enter>')

    -- Window movement
    vis:map(vis.modes.NORMAL, '<C-h>', '<C-w>h')
    vis:map(vis.modes.NORMAL, '<C-j>', '<C-w>j')
    vis:map(vis.modes.NORMAL, '<C-k>', '<C-w>k')
    vis:map(vis.modes.NORMAL, '<C-l>', '<C-w>l')
    
    -- System clipboard integration
    vis:map(vis.modes.NORMAL, '<Space>p', '"+p')
    vis:map(vis.modes.VISUAL, '<Space>x', '"+d')
end)
