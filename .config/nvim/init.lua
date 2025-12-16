-- ============================================
-- NEOVIM CONFIGURATION - MINIMAL
-- ============================================

-- ---- Basic Settings ----
vim.opt.number = true              -- Show line numbers
vim.opt.relativenumber = true      -- Relative line numbers
vim.opt.expandtab = true           -- Use spaces instead of tabs
vim.opt.shiftwidth = 2             -- Indent width
vim.opt.tabstop = 2                -- Tab width
vim.opt.smartindent = true         -- Smart autoindenting
vim.opt.wrap = true                -- Wrap long lines
vim.opt.linebreak = true           -- Break lines at word boundaries
vim.opt.mouse = 'a'                -- Enable mouse support
vim.opt.ignorecase = true          -- Case-insensitive search
vim.opt.smartcase = true           -- Case-sensitive if uppercase present
vim.opt.clipboard = 'unnamedplus'  -- Use system clipboard
vim.opt.termguicolors = true       -- Enable 24-bit RGB colors
vim.opt.cursorline = true          -- Highlight current line
vim.opt.signcolumn = 'yes'         -- Always show sign column
vim.opt.updatetime = 300           -- Faster completion
vim.opt.timeoutlen = 500           -- Faster key sequence completion
vim.opt.undofile = true            -- Persistent undo
vim.opt.scrolloff = 8              -- Keep 8 lines above/below cursor

-- ---- Leader Key ----
vim.g.mapleader = ' '              -- Space as leader key
vim.g.maplocalleader = ' '

-- ---- Key Mappings ----
local keymap = vim.keymap

-- Save file
keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })

-- Quit
keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit' })

-- Save and quit
keymap.set('n', '<leader>x', ':wq<CR>', { desc = 'Save and quit' })

-- Clear search highlighting
keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Better window navigation
keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Resize windows
keymap.set('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
keymap.set('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })

-- Better indenting
keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Move selected lines up/down
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Stay in center when scrolling
keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })

-- Keep cursor in place when joining lines
keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines' })

-- Better paste (don't overwrite register)
keymap.set('v', 'p', '"_dP', { desc = 'Paste without overwriting register' })

-- ---- File Explorer ----
keymap.set('n', '<leader>e', ':Explore<CR>', { desc = 'Open file explorer' })

-- ---- Auto Commands ----
-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('remove_trailing_whitespace', { clear = true }),
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

-- ---- Color Scheme ----
-- Use Catppuccin Mocha colors if available
vim.cmd([[
  try
    colorscheme habamax
  catch /^Vim\%((\a\+)\)\=:E185/
    " Colorscheme not found, use default
  endtry
]])

-- Custom highlight overrides for better visibility
vim.cmd([[
  highlight LineNr guifg=#6c7086
  highlight CursorLineNr guifg=#cba6f7 gui=bold
  highlight CursorLine guibg=#1e1e2e
  highlight SignColumn guibg=#181825
  highlight Visual guibg=#313244
]])

-- ---- Status Line ----
vim.opt.laststatus = 2
vim.opt.showmode = false

-- Simple custom statusline
vim.opt.statusline = '%#StatusLine#'
  .. ' %f'                          -- File path
  .. ' %m%r%h%w'                    -- Modified/readonly/help/preview flags
  .. '%='                           -- Right align
  .. ' %y'                          -- File type
  .. ' %l:%c'                       -- Line:Column
  .. ' %p%% '                       -- Percentage through file

print("NeoVim configured successfully!")
