return {
  {
    'lambdalisue/vim-suda',
    cmd = { 'SudaRead', 'SudaWrite' },
    init = function()
      vim.g.suda_smart_edit = 0
    end,
  },
}
