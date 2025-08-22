return {
  'hoangtan-dev/octocode.nvim',
  config = function()
    require('octocode').setup {
      -- Keybindings
      keymaps = {
        toggle = '<leader>so',
        select = '<CR>',
        close = '<Esc>',
        mode_all = 'a',
        mode_code = 'c',
        mode_docs = 'd',
        mode_text = 't',
      },
    }
  end,
}
