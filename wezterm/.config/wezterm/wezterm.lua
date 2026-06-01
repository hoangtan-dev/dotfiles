local wezterm = require 'wezterm'
local commands = require 'commands'
local constants = require 'constants'

local config = wezterm.config_builder()

-- Font settings
config.font_size = 16
config.line_height = 1.2

config.font = wezterm.font_with_fallback {
  {
    family = 'Space Mono',
  },
  {
    family = 'Symbols Nerd Font Mono',
  },
}

config.font_rules = {
  {
    intensity = 'Bold',
    font = wezterm.font('Space Mono', {
      weight = 'Bold',
    }),
  },
  {
    italic = true,
    font = wezterm.font('Space Mono', {
      style = 'Italic',
    }),
  },
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font('Space Mono', {
      weight = 'Bold',
      style = 'Italic',
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
config.window_decorations = 'NONE'
config.native_macos_fullscreen_mode = true

-- Miscellaneous settings
config.max_fps = 120
config.prefer_egl = true

-- Wayland support
config.enable_wayland = true

-- Keybindings
config.keys = {
  -- MacOS: Toggle Full Screen
  { key = 'f', mods = 'CTRL|CMD', action = wezterm.action.ToggleFullScreen },
}

-- Custom commands
wezterm.on('augment-command-palette', function()
  return commands
end)

return config
