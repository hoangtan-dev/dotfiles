-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'echasnovski/mini.icons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    {
      '<leader>e',
      ':Neotree reveal<CR>',
      desc = 'NeoTree reveal',
      silent = true,
    },
  },
  opts = {
    sources = {
      'filesystem',
      'buffers',
      'git_status',
    },
    window = {
      position = 'right',
      width = 30,
      mappings = {
        ['Y'] = 'none',
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = '',
        expander_expanded = '',
        expander_highlight = 'NeoTreeExpander',
      },
      git_status = {
        symbols = {
          unstaged = '󰄱',
          staged = '󰱒',
          untracked = '✚',
        },
      },
      icon = {
        provider = function(icon, node) -- setup a custom icon provider
          local text, hl
          local mini_icons =
            require 'mini.icons'
          if node.type == 'file' then -- if it's a file, set the text/hl
            text, hl = mini_icons.get(
              'file',
              node.name
            )
          elseif
            node.type == 'directory'
          then -- get directory icons
            text, hl = mini_icons.get(
              'directory',
              node.name
            )
            -- only set the icon text if it is not expanded
            if node:is_expanded() then
              text = nil
            end
          end

          -- set the icon text/highlight only if it exists
          if text then
            icon.text = text
          end
          if hl then
            icon.highlight = hl
          end
        end,
      },
    },
    filesystem = {
      bind_to_cwd = false,
      find_by_full_path_words = true,
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        always_show_by_pattern = { -- uses glob style patterns
          '.env*',
        },
        hide_by_name = {
          '.git',
          '.DS_Store',
          '__pycache__',
        },
        always_show = {
          '.env',
        },
      },
      window = {
        mappings = {
          ['<leader>e'] = 'close_window',
        },
      },
    },
  },
}
