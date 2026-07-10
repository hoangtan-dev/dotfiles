return {
  '3rd/image.nvim',
  build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  opts = {
    processor = 'magick_cli',
    backend = 'kitty', -- whatever backend you would like to use
    max_width = 100,
    max_height = 12,
    max_height_window_percentage = math.huge,
    max_width_window_percentage = math.huge,
    window_overlap_clear_enabled = true,
    tmux_show_only_in_active_window = true,
    window_overlap_clear_ft_ignore = {
      'cmp_menu',
      'cmp_docs',
      '',
    },
  },
}
