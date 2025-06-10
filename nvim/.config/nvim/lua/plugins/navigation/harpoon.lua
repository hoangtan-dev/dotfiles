---@param items any[]
---@param length number
---@param element any
---@param config HarpoonPartialConfigItem?
local function index_of(
  items,
  length,
  element,
  config
)
  local equals = config
      and config.equals
    or function(a, b)
      return a == b
    end

  for i = 1, length do
    local item = items[i]
    if equals(element, item) then
      return i
    end
  end

  return -1
end

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'

    -- Setup harpoon
    harpoon:setup {}

    -- Basic keymaps
    vim.keymap.set(
      'n',
      '<C-a>',
      function()
        local list = harpoon:list()
        local item =
          list.config.create_list_item(
            list.config
          )

        local index = index_of(
          list.items,
          list._length,
          item,
          list.config
        )
        if index ~= -1 then
          list:remove(item)
        else
          list:add(item)
        end
      end
    )

    vim.keymap.set(
      'n',
      '<C-e>',
      function()
        harpoon.ui:toggle_quick_menu(
          harpoon:list()
        )
      end
    )

    -- Toggle previous & next
    vim.keymap.set(
      'n',
      '<C-S-P>',
      function()
        harpoon:list():prev()
      end
    )
    vim.keymap.set(
      'n',
      '<C-S-N>',
      function()
        harpoon:list():next()
      end
    )

    -- Telescope integration
    local conf =
      require('telescope.config').values
    local function toggle_telescope(
      harpoon_files
    )
      local file_paths = {}
      for _, item in
        ipairs(harpoon_files.items)
      do
        table.insert(
          file_paths,
          item.value
        )
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require(
            'telescope.finders'
          ).new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set(
      'n',
      '<C-e>',
      function()
        toggle_telescope(harpoon:list())
      end,
      { desc = 'Open harpoon window' }
    )
  end,
}
