return {
  'akinsho/nvim-toggleterm.lua',
  config = function()
    local toggleterm =
      require 'toggleterm'

    toggleterm.setup {
      open_mapping = [[<c-\>]],
      hide_number = true,
      start_in_insert = true,
      direction = 'horizontal', -- vertical | float | tab
      shade_terminals = true,
      shading_factor = 2,
      insert_mappings = true,
      persist_size = true,
    }
  end,
}
