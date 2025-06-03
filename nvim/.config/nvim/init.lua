vim.g.mapleader = ' '

vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

for _, mode in pairs {
  'n',
  'i',
  'v',
  'x',
} do
  for _, key in pairs {
    '<Up>',
    '<Down>',
    '<Left>',
    '<Right>',
  } do
    vim.keymap.set(mode, key, '<nop>')
  end
end

-- Set NeoTreeGitUntracked highlight group to a better green
vim.api.nvim_set_hl(
  0,
  'NeoTreeGitUntracked',
  {
    fg = '#32CD32', -- LimeGreen color (more vibrant)
    bg = nil, -- No background color
    bold = false,
    italic = false,
    undercurl = false,
  }
)

require 'globals'
require 'options'
require 'keymaps'
require 'lazy-init'
