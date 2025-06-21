return {
  'polarmutex/git-worktree.nvim',
  version = '^2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local previewers =
      require 'telescope.previewers'
    local git_worktree = require(
      'telescope'
    ).extensions.git_worktree
    vim.keymap.set(
      'n',
      '<leader>gwm',
      function()
        git_worktree.git_worktree {
          previewer = previewers.new_termopen_previewer {
            get_command = function(
              entry
            )
              return {
                'git',
                '--no-pager',
                '-C',
                entry.path,
                'log',
                '--graph',
                '--pretty=oneline',
                '--abbrev-commit',
                '--pretty=format:%C(auto)%h %s %C(blue)%cr %C(green)(%an)',
                '--color=always',
                '-n',
                '20',
              }
            end,
          },
          layout_strategy = 'horizontal',
          layout_config = {
            width = 0.95, -- 95% of the screen
            preview_width = 0.4, -- 70% preview, 30% list
          },
        }
      end,
      {
        desc = 'Git Worktree List',
        silent = true,
      }
    )
    vim.keymap.set(
      'n',
      '<leader>gwc',
      function()
        git_worktree.create_git_worktree {}
      end,
      {
        silent = true,
        desc = 'Git Worktree Create',
      }
    )
    local Hooks =
      require 'git-worktree.hooks'
    local config =
      require 'git-worktree.config'
    local update_on_switch =
      Hooks.builtins.update_current_buffer_on_switch

    Hooks.register(
      Hooks.type.SWITCH,
      function(path, prev_path)
        vim.notify(
          'Moved from '
            .. prev_path
            .. ' to '
            .. path
        )
        update_on_switch(
          path,
          prev_path
        )
      end
    )

    Hooks.register(
      Hooks.type.DELETE,
      function()
        vim.cmd(
          config.update_on_change_command
        )
      end
    )
  end,
}
