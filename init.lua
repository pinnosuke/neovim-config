-- Leader/local leader
vim.g.mapleader = [[;]]

-- Settings
vim.opt.scrolloff = 5
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.smartindent = true
vim.opt.showmode = false
vim.opt.shada = [['20,<50,s10,h,/100]]
vim.opt.hidden = true
vim.opt.shortmess:append 'c'
vim.opt.joinspaces = false
vim.opt.undofile = true
vim.opt.mouse = 'nivh'
vim.opt.signcolumn = 'yes:1'
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Colorscheme
vim.opt.termguicolors = true
vim.opt.background = 'dark'
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
    colorscheme habamax
  endtry
]]

-- Keybindings
vim.keymap.set('c', '<C-p>', '<UP>')
vim.keymap.set('c', '<C-n>', '<DOWN>')
vim.keymap.set('c', '<C-b>', '<LEFT>')
vim.keymap.set('c', '<C-f>', '<RIGHT>')
vim.keymap.set('c', '<C-a>', '<HOME>')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'q:', '<NOP>')

require('plugins')
