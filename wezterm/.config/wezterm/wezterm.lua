local wezterm = require 'wezterm'
local commands = require 'commands'
local constants = require 'constants'

local config = wezterm.config_builder()

-- Font settings
config.font_size = 16
config.line_height = 1.2
config.font = wezterm.font_with_fallback {
  {
    family = 'Dank Mono',
    harfbuzz_features = {
      'calt',
      'ss01',
      'ss02',
      'ss03',
      'ss04',
      'ss05',
      'ss06',
      'ss07',
      'ss08',
      'ss09',
      'liga',
    },
  },
  { family = 'Symbols Nerd Font Mono' },
}
config.font_rules = {
  {
    font = wezterm.font('Dank Mono', {
      bold = true,
    }),
  },
  {
    italic = true,
    font = wezterm.font('Dank Mono', {
      italic = true,
    }),
  },
}

-- Colors
config.colors = require 'cyberdream'
config.window_background_image = constants.bg_image

-- Appearance
config.cursor_blink_rate = 0
-- config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.macos_window_background_blur = 40

-- Miscellaneous settings
config.max_fps = 120
config.prefer_egl = true

-- Wayland support
config.enable_wayland = false

-- Custom commands
wezterm.on('augment-command-palette', function()
  return commands
end)

return config
