return {
  {
    'hoangtan-dev/xolaani.nvim',
    branch = 'develop',
    lazy = false,
    priority = 1000,
    config = function()
      -- Config for xolaani
      require('xolaani').setup {
        plugins = {
          indent_blankline = false,
        },
      }
      -- Load the colorscheme
      vim.cmd.colorscheme 'xolaani'

      -- Set transparency
      vim.cmd [[
      hi Normal guibg=NONE ctermbg=NONE
      hi NormalNC guibg=NONE ctermbg=NONE
      hi EndOfBuffer guibg=NONE ctermbg=NONE guifg=NONE
      hi LineNr guibg=NONE ctermbg=NONE
      hi SignColumn guibg=NONE ctermbg=NONE
      hi VertSplit guibg=NONE ctermbg=NONE
      hi StatusLine guibg=NONE ctermbg=NONE
    ]]
    end,
  },
  -- {
  --   dir = '~/Repositories/personal/nvim-plugins/xolaani.nvim', -- or wherever your local folder is
  --   name = 'xolaani.nvim', -- optional but recommended for clarity
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('xolaani').setup {
  --       plugins = {
  --         indent_blankline = false,
  --         -- other plugins you want to enable
  --       },
  --     }
  --     vim.cmd.colorscheme 'xolaani'
  --
  --     vim.cmd [[
  --     hi Normal guibg=NONE ctermbg=NONE
  --     hi NormalNC guibg=NONE ctermbg=NONE
  --     hi EndOfBuffer guibg=NONE ctermbg=NONE guifg=NONE
  --     hi LineNr guibg=NONE ctermbg=NONE
  --     hi SignColumn guibg=NONE ctermbg=NONE
  --     hi VertSplit guibg=NONE ctermbg=NONE
  --     hi StatusLine guibg=NONE ctermbg=NONE
  --   ]]
  --   end,
  -- },
}
