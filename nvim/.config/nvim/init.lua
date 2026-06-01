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

-- Enable Spell checking for markdown and gitcommit filetypes
vim.api.nvim_create_autocmd(
  'FileType',
  {
    pattern = {
      'markdown',
      'text',
      'gitcommit',
    },
    callback = function()
      vim.opt_local.spell = true
      vim.opt_local.spelllang =
        { 'en_us' }
    end,
  }
)
-- Hardcore mode toggle (default OFF)
vim.g.hardcore_mode = false

local last_key = nil
local repeat_count = 0
local max_repeat = 3

local function hardcore_handler(key)
  return function()
    if not vim.g.hardcore_mode then
      return key
    end

    if last_key == key then
      repeat_count = repeat_count + 1
    else
      last_key = key
      repeat_count = 1
    end

    if repeat_count >= max_repeat then
      vim.notify(
        'Hardcore mode: use leap.nvim!',
        vim.log.levels.WARN
      )
      return '' -- block movement
    end

    return key
  end
end

-- Apply to normal mode
for _, key in ipairs {
  'h',
  'j',
  'k',
  'l',
} do
  vim.keymap.set(
    'n',
    key,
    hardcore_handler(key),
    { expr = true, silent = true }
  )
end

vim.api.nvim_create_user_command(
  'ToggleHardcore',
  function()
    vim.g.hardcore_mode =
      not vim.g.hardcore_mode
    print(
      'Hardcore mode: '
        .. (
          vim.g.hardcore_mode and 'ON'
          or 'OFF'
        )
    )
  end,
  {}
)

require 'globals'
require 'options'
require 'keymaps'
require 'lazy-init'
