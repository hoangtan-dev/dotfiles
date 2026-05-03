return {
  {
    'ggandor/flit.nvim',
    enabled = true,
    keys = function()
      local ret = {}
      for _, key in ipairs {
        'f',
        'F',
        't',
        'T',
      } do
        ret[#ret + 1] = {
          key,
          mode = { 'n', 'x', 'o' },
        }
      end
      return ret
    end,
    opts = { labeled_modes = 'nx' },
  },
  {
    'https://codeberg.org/andyg/leap.nvim',
    enabled = true,
    config = function(_, opts)
      local leap = require 'leap'
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.set(
        { 'n', 'x', 'o' },
        's',
        '<Plug>(leap)'
      )
      vim.keymap.set(
        'n',
        'S',
        '<Plug>(leap-from-window)'
      )
      vim.keymap.set(
        { 'n', 'o' },
        'gs',
        '<Plug>(leap-remote)'
      )

      vim.keymap.del({ 'x', 'o' }, 'x')
      vim.keymap.del({ 'x', 'o' }, 'X')

      -- Highly recommended: define a preview filter to reduce visual noise
      -- and the blinking effect after the first keypress.
      -- For example, define word boundaries as the common case, that is, skip
      -- preview for matches starting with whitespace or an alphabetic
      -- mid-word character: foobar[baaz] = quux
      --                     *    ***  ** * *  *
      require('leap').opts.preview = function(
        ch0,
        ch1,
        ch2
      )
        return not (
          ch1:match '%s'
          or (
            ch0:match '%a'
            and ch1:match '%a'
            and ch2:match '%a'
          )
        )
      end
    end,
  },

  -- rename surround mappings from gs to gz to prevent conflict with leap
  {
    'echasnovski/mini.surround',
    optional = true,
    opts = {
      mappings = {
        add = 'gza', -- Add surrounding in Normal and Visual modes
        delete = 'gzd', -- Delete surrounding
        find = 'gzf', -- Find surrounding (to the right)
        find_left = 'gzF', -- Find surrounding (to the left)
        highlight = 'gzh', -- Highlight surrounding
        replace = 'gzr', -- Replace surrounding
        update_n_lines = 'gzn', -- Update `n_lines`
      },
    },
    keys = {
      { 'gz', '', desc = '+surround' },
    },
  },

  -- makes some plugins dot-repeatable like leap
  {
    'tpope/vim-repeat',
    event = 'VeryLazy',
  },
}
