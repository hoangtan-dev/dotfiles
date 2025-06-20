return {
  {
    'smjonas/inc-rename.nvim',
    cmd = 'IncRename',
    config = function()
      require('inc_rename').setup {
        input_buffer_type = 'dressing',
        post_hook = function()
          vim.lsp.codelens.refresh()
        end,
      }
    end,
  },
}
