return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    -- main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    config = function()
      require('nvim-treesitter').setup {
        ensure_installed = {
          'bash',
          'c',
          'diff',
          'html',
          'lua',
          'luadoc',
          'markdown',
          'markdown_inline',
          'query',
          'vim',
          'vimdoc',
          'ninja',
          'rst',
          'python',
        },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
          enable = true,
          -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
          --  If you are experiencing weird indenting issues, add the language to
          --  the list of additional_vim_regex_highlighting and disabled languages for indent.
          additional_vim_regex_highlighting = {
            'ruby',
          },
        },
        indent = {
          enable = true,
          disable = { 'ruby' },
        },
      }
    end,
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true
    end,
    config = function()
      -- configuration
      require(
        'nvim-treesitter-textobjects'
      ).setup {
        select = {
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = 'V', -- linewise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          include_surrounding_whitespace = false,
        },
        move = {
          set_jumps = true,
        },
      }

      -- keymaps
      -- Select
      local select =
        require 'nvim-treesitter-textobjects.select'

      vim.keymap.set(
        { 'x', 'o' },
        'af',
        function()
          select.select_textobject(
            '@function.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'x', 'o' },
        'if',
        function()
          select.select_textobject(
            '@function.inner',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'x', 'o' },
        'ac',
        function()
          select.select_textobject(
            '@class.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'x', 'o' },
        'ic',
        function()
          select.select_textobject(
            '@class.inner',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'x', 'o' },
        'ab',
        function()
          select.select_textobject(
            '@block.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'x', 'o' },
        'ib',
        function()
          select.select_textobject(
            '@block.inner',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'x', 'o' },
        'al',
        function()
          select.select_textobject(
            '@loop.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'x', 'o' },
        'il',
        function()
          select.select_textobject(
            '@loop.inner',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'x', 'o' },
        'a/',
        function()
          select.select_textobject(
            '@comment.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'x', 'o' },
        'i/',
        function()
          select.select_textobject(
            '@comment.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'x', 'o' },
        'aa',
        function()
          select.select_textobject(
            '@parameter.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'x', 'o' },
        'ia',
        function()
          select.select_textobject(
            '@parameter.inner',
            'textobjects'
          )
        end
      )

      -- Move
      local move =
        require 'nvim-treesitter-textobjects.move'

      -- next start
      vim.keymap.set(
        { 'n', 'x', 'o' },
        'gj',
        function()
          move.goto_next_start(
            '@function.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'n', 'x', 'o' },
        ']m',
        function()
          move.goto_next_start(
            '@class.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'n', 'x', 'o' },
        ']b',
        function()
          move.goto_next_start(
            '@block.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'n', 'x', 'o' },
        ']a',
        function()
          move.goto_next_start(
            '@parameter.inner',
            'textobjects'
          )
        end
      )

      -- next end
      vim.keymap.set(
        { 'n', 'x', 'o' },
        'gJ',
        function()
          move.goto_next_end(
            '@function.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'n', 'x', 'o' },
        ']M',
        function()
          move.goto_next_end(
            '@class.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'n', 'x', 'o' },
        ']B',
        function()
          move.goto_next_end(
            '@block.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'n', 'x', 'o' },
        ']A',
        function()
          move.goto_next_end(
            '@parameter.inner',
            'textobjects'
          )
        end
      )

      -- previous start
      vim.keymap.set(
        { 'n', 'x', 'o' },
        'gk',
        function()
          move.goto_previous_start(
            '@function.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'n', 'x', 'o' },
        '[m',
        function()
          move.goto_previous_start(
            '@class.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'n', 'x', 'o' },
        '[b',
        function()
          move.goto_previous_start(
            '@block.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'n', 'x', 'o' },
        '[a',
        function()
          move.goto_previous_start(
            '@parameter.inner',
            'textobjects'
          )
        end
      )

      -- previous end
      vim.keymap.set(
        { 'n', 'x', 'o' },
        'gK',
        function()
          move.goto_previous_end(
            '@function.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'n', 'x', 'o' },
        '[M',
        function()
          move.goto_previous_end(
            '@class.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'n', 'x', 'o' },
        '[B',
        function()
          move.goto_previous_end(
            '@block.outer',
            'textobjects'
          )
        end
      )

      vim.keymap.set(
        { 'n', 'x', 'o' },
        '[A',
        function()
          move.goto_previous_end(
            '@parameter.inner',
            'textobjects'
          )
        end
      )
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
