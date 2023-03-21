local utils = require('utils')
local opt = utils.opt
local autocmd = utils.autocmd

-- Leader/local leader
vim.g.mapleader = [[;]]
vim.g.maplocalleader = [[,]]

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
  'gzip',
  'matchit',
  'matchparen',
  'netrwPlugin',
  'spellfile',
  'tarPlugin',
  'tohtml',
  'tutor',
  'zipPlugin',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

-- Settings
local buffer = { vim.o, vim.bo }
local window = { vim.o, vim.wo }
opt('textwidth', 100, buffer)
opt('scrolloff', 3)
opt('wildignore', '*.o,*~,*.pyc')
opt('wildmode', 'longest,full')
opt('whichwrap', vim.o.whichwrap .. '<,>')
opt('inccommand', 'nosplit')
opt('lazyredraw', true)
opt('showmatch', true)
opt('ignorecase', true)
opt('smartcase', true)
opt('tabstop', 2, buffer)
opt('softtabstop', 0, buffer)
opt('expandtab', true, buffer)
opt('shiftwidth', 2, buffer)
opt('number', true, window)
opt('relativenumber', false, window)
opt('smartindent', true, buffer)
opt('laststatus', 2)
opt('showmode', false)
opt('shada', [['20,<50,s10,h,/100]])
opt('hidden', true)
opt('shortmess', vim.o.shortmess .. 'c')
opt('joinspaces', false)
opt('guicursor', [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]])
opt('updatetime', 500)
opt('conceallevel', 2, window)
opt('concealcursor', 'nc', window)
opt('previewheight', 5)
opt('undofile', true, buffer)
opt('synmaxcol', 500, buffer)
opt('display', 'msgsep')
opt('cursorline', true, window)
opt('modeline', false, buffer)
opt('mouse', 'nivh')
opt('signcolumn', 'yes:1', window)
opt('splitright', true)
opt('splitbelow', true)
opt('wrap', false)

-- Colorscheme
opt('termguicolors', true)
opt('background', 'dark')
vim.cmd [[
  " colorscheme is lazy
  autocmd ColorScheme * hi Normal guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi LineNr guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi SignColumn guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi EndOfBuffer guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi RedSign ctermbg=NONE guibg=NONE
  autocmd ColorScheme * hi GreenSign ctermbg=NONE guibg=NONE
  autocmd ColorScheme * hi BlueSign ctermbg=NONE guibg=NONE
  autocmd ColorScheme * hi OrangeSign ctermbg=NONE guibg=NONE
  autocmd ColorScheme * hi PurpleSign ctermbg=NONE guibg=NONE
  autocmd ColorScheme * hi YellowSign ctermbg=NONE guibg=NONE
  autocmd ColorScheme * hi AquaSign ctermbg=NONE guibg=NONE
  try
    colorscheme OceanicNext
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme elflord
  endtry
]]

-- neovide
if vim.g.neovide == true then
  -- opt('guifont', 'HackGenNerd:h11')
  opt('guifont', 'HackGen Console NF:h16')
  opt('ambiwidth', 'single')
  vim.g.neovide_transparency = 0.8
  vim.g.python3_host_prog = '~/.asdf/shims/python'
end

-- Keybindings
vim.keymap.set('c', '<C-p>', '<UP>')
vim.keymap.set('c', '<C-n>', '<DOWN>')
vim.keymap.set('c', '<C-b>', '<LEFT>')
vim.keymap.set('c', '<C-f>', '<RIGHT>')
vim.keymap.set('c', '<C-a>', '<HOME>')
vim.keymap.set('n', 'q:', '<NOP>')

require('plugins')
