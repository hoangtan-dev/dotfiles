return {
  {
    'stevearc/conform.nvim',
    opts = {
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if
          vim.g.disable_autoformat
          or vim.b[bufnr].disable_autoformat
        then
          return
        end
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
    config = function(_, opts)
      -- Set global default to enable autoformat
      vim.g.disable_autoformat = false

      require('conform').setup(opts)

      -- Define user commands for enabling/disabling autoformat
      vim.api.nvim_create_user_command(
        'FormatDisable',
        function(args)
          if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat =
              true
          else
            vim.g.disable_autoformat =
              true
          end
        end,
        {
          desc = 'Disable autoformat-on-save',
          bang = true,
        }
      )

      vim.api.nvim_create_user_command(
        'FormatEnable',
        function()
          vim.b.disable_autoformat =
            false
          vim.g.disable_autoformat =
            false
        end,
        {
          desc = 'Re-enable autoformat-on-save',
        }
      )
    end,
  },
}
