return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'c', 'cpp' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        clangd = {
          filetypes = {
            'c',
            'cpp',
            'objc',
            'objcpp',
          },
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--completion-style=detailed',
            '--header-insertion=never',
          },
        },
      },
    },
  },
}
