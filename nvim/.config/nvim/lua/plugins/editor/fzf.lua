local kind_filter = {
  default = {
    'Class',
    'Constructor',
    'Enum',
    'Field',
    'Function',
    'Interface',
    'Method',
    'Module',
    'Namespace',
    'Package',
    'Property',
    'Struct',
    'Trait',
  },
  markdown = false,
  help = false,
  -- you can specify a different filter for each filetype
  lua = {
    'Class',
    'Constructor',
    'Enum',
    'Field',
    'Function',
    'Interface',
    'Method',
    'Module',
    'Namespace',
    -- "Package", -- remove package since luals uses it for control flow structures
    'Property',
    'Struct',
    'Trait',
  },
}

local get_kind_filter = function(buf)
  buf = (buf == nil or buf == 0)
      and vim.api.nvim_get_current_buf()
    or buf
  local ft = vim.bo[buf].filetype
  if kind_filter[ft] == false then
    return
  end
  if
    type(kind_filter[ft]) == 'table'
  then
    return kind_filter[ft]
  end
  ---@diagnostic disable-next-line: return-type-mismatch
  return type(kind_filter) == 'table'
      and type(kind_filter.default) == 'table'
      and kind_filter.default
    or nil
end

local symbols_filter = function(
  entry,
  ctx
)
  if ctx.symbols_filter == nil then
    ctx.symbols_filter = get_kind_filter(
      ctx.bufnr
    ) or false
  end
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(
    ctx.symbols_filter,
    entry.kind
  )
end

return {
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = {
      'echasnovski/mini.icons',
    },
    opts = function(_, opts)
      opts.keymap = {
        builtin = {
          true,
          ['<Esc>'] = 'hide',
        },
      }

      opts.hls = {
        cursorline = 'CursorLine',
        cursorlinenr = 'CursorLineNr',
      }

      opts.defaults = {
        formatter = 'path.filename_first',
      }

      opts.fzf_colors = {
        ['gutter'] = '-1',
        fzf_colors = {
          true, -- inherit fzf colors that aren't specified below from
          -- the auto-generated theme similar to `fzf_colors=true`
          ['fg'] = {
            'fg',
            'CursorLine',
          },
          ['bg'] = { 'bg', 'Normal' },
          ['hl'] = { 'fg', 'Comment' },
          ['fg+'] = {
            'fg',
            'Normal',
            'underline',
          },
          ['bg+'] = {
            'bg',
            { 'CursorLine', 'Normal' },
          },
          ['hl+'] = {
            'fg',
            'Statement',
          },
          ['info'] = { 'fg', 'PreProc' },
          ['prompt'] = {
            'fg',
            'Conditional',
          },
          ['pointer'] = {
            'fg',
            'Exception',
          },
          ['marker'] = {
            'fg',
            'Keyword',
          },
          ['spinner'] = {
            'fg',
            'Label',
          },
          ['header'] = {
            'fg',
            'Comment',
          },
        },
      }

      opts.grep = vim.tbl_deep_extend(
        'force',
        opts.grep or {},
        {
          rg_opts = '--column --line-number --hidden '
            .. "--glob '!.git/*' "
            .. "--glob '!node_modules/*' "
            .. "--glob '!.env/*' "
            .. "--glob '!.mypy_cache/*' "
            .. "--glob '!.dockerignore' "
            .. "--glob '!.db_backups/*' "
            .. "--glob '!__pycache__/*' ",
          actions = {
            ['ctrl-i'] = require(
              'fzf-lua.actions'
            ).toggle_ignore,
            ['ctrl-h'] = require(
              'fzf-lua.actions'
            ).toggle_hidden,
            ['enter'] = {
              fn = function(sel, o)
                require('fzf-lua').hide()
                require(
                  'fzf-lua.actions'
                ).file_edit_or_qf(
                  sel,
                  o
                )
              end,
              exec_silent = true,
            },
          },
        }
      )

      opts.files = vim.tbl_deep_extend(
        'force',
        opts.files or {},
        {
          actions = {
            ['ctrl-i'] = require(
              'fzf-lua.actions'
            ).toggle_ignore,
            ['ctrl-h'] = require(
              'fzf-lua.actions'
            ).toggle_hidden,
            ['enter'] = {
              fn = function(sel, o)
                require('fzf-lua').hide()
                require(
                  'fzf-lua.actions'
                ).file_edit_or_qf(
                  sel,
                  o
                )
              end,
              exec_silent = true,
            },
          },
        }
      )
    end,
    keys = {
      {
        '<c-j>',
        '<c-j>',
        ft = 'fzf',
        mode = 't',
        nowait = true,
      },
      {
        '<c-k>',
        '<c-k>',
        ft = 'fzf',
        mode = 't',
        nowait = true,
      },
      -- find
      {
        '<leader>fb',
        '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>',
        desc = 'Buffers',
      },
      {
        '<leader><space>',
        '<cmd>FzfLua files<cr>',
        desc = 'Find Files',
      },
      {
        '<leader>fg',
        '<cmd>FzfLua git_files<cr>',
        desc = 'Git-files',
      },

      -- search
      {
        '<leader>s"',
        '<cmd>FzfLua registers<cr>',
        desc = 'Registers',
      },
      {
        '<leader>sa',
        '<cmd>FzfLua autocmds<cr>',
        desc = 'Auto Commands',
      },
      {
        '<leader>sb',
        '<cmd>FzfLua grep_curbuf<cr>',
        desc = 'Buffer',
      },
      {
        '<leader>sC',
        '<cmd>FzfLua command_history<cr>',
        desc = 'Command History',
      },
      {
        '<leader>sd',
        '<cmd>FzfLua diagnostics_document<cr>',
        desc = 'Document Diagnostics',
      },
      {
        '<leader>sD',
        '<cmd>FzfLua diagnostics_workspace<cr>',
        desc = 'Workspace Diagnostics',
      },
      {
        '<leader>sg',
        '<cmd>FzfLua live_grep_native<cr>',
        desc = 'Grep',
      },
      {
        '<leader>sh',
        '<cmd>FzfLua help_tags<cr>',
        desc = 'Help Pages',
      },
      {
        '<leader>sH',
        '<cmd>FzfLua highlights<cr>',
        desc = 'Highlight Groups',
      },
      {
        '<leader>sj',
        '<cmd>FzfLua jumps<cr>',
        desc = 'Jumplist',
      },
      {
        '<leader>sk',
        '<cmd>FzfLua keymaps<cr>',
        desc = 'Key Maps',
      },
      {
        '<leader>sl',
        '<cmd>FzfLua loclist<cr>',
        desc = 'Location List',
      },
      {
        '<leader>sM',
        '<cmd>FzfLua man_pages<cr>',
        desc = 'Man Pages',
      },
      {
        '<leader>sm',
        '<cmd>FzfLua marks<cr>',
        desc = 'Jump to Mark',
      },
      {
        '<leader>,',
        '<cmd>FzfLua resume<cr>',
        desc = 'Resume',
      },
      {
        '<leader>sq',
        '<cmd>FzfLua quickfix<cr>',
        desc = 'Quickfix List',
      },
      {
        '<leader>sS',
        function()
          require('fzf-lua').lsp_document_symbols {
            regex_filter = symbols_filter,
          }
        end,
        desc = 'Symbol (Document)',
      },
      {
        '<leader>ss',
        function()
          require('fzf-lua').lsp_live_workspace_symbols {
            regex_filter = symbols_filter,
          }
        end,
        desc = 'Symbol (Workspace)',
      },
      {
        '<leader>d<space>',
        function()
          require('fzf-lua').files {
            cmd = 'fd -t=d',
            cwd = require('oil').get_current_dir(),
          }
        end,
        desc = 'FzfLua(Oil)',
      },
      {
        '<leader>ff',
        '<cmd>FzfLua git_status<cr>',
        desc = 'Git Files Changed',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = function()
      -- stylua: ignore
      vim.keymap.set('n', 'gd', '<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>', { desc = "Goto Definition" })
      -- stylua: ignore
      vim.keymap.set('n', 'gr', '<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>', { desc = "References", nowait = true })
      -- stylua: ignore
      vim.keymap.set('n', 'gI', '<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>', { desc = "Goto Implementation" })
      -- stylua: ignore
      vim.keymap.set('n', 'gy', '<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>', { desc = "Goto Type Definitions" })
    end,
  },
}
