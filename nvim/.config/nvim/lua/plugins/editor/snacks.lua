return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      picker = {
        enabled = true,
        sources = {
          harpoon = {
            finder = function()
              local harpoon =
                require 'harpoon'
              local output = {}
              for _, item in
                ipairs(
                  harpoon:list().items
                )
              do
                if
                  item
                  and item.value:match '%S'
                then
                  table.insert(output, {
                    text = item.value,
                    file = item.value,
                    pos = {
                      item.context.row,
                      item.context.col,
                    },
                  })
                end
              end
              return output
            end,
            filter = {
              -- reruns the finder on changes
              transform = function()
                if changed then
                  changed = false
                  return true
                end
              end,
            },
            format = function(item)
              return {
                { item.text },
                {
                  ':',
                  'SnacksPickerDelim',
                },
                {
                  tostring(item.pos[1]),
                  'SnacksPickerRow',
                },
                {
                  ':',
                  'SnacksPickerDelim',
                },
                {
                  tostring(item.pos[2]),
                  'SnacksPickerCol',
                },
              }
            end,
            preview = function(ctx)
              if
                Snacks.picker.util.path(
                  ctx.item
                )
              then
                return Snacks.picker.preview.file(
                  ctx
                )
              else
                return Snacks.picker.preview.none(
                  ctx
                )
              end
            end,
            confirm = 'jump',
          },
        },
      },
    },
    keys = {
      -- Top Pickers & Explorer
      {
        '<leader><space>',
        function()
          Snacks.picker.smart {
            multi = {
              'buffers',
              'files',
            },
            format = 'file',
            matcher = {
              cwd_bonus = true,
              frecency = true,
              sort_empty = true,
            },
            transform = 'unique_file',
          }
        end,
        desc = 'Smart Find Files',
      },
      {
        '<leader>,',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>:',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      -- find
      {
        '<leader>fb',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>fc',
        function()
          Snacks.picker.files {
            cwd = vim.fn.stdpath 'config',
          }
        end,
        desc = 'Find Config File',
      },
      {
        '<leader>ff',
        function()
          Snacks.picker.files()
        end,
        desc = 'Find Files',
      },
      {
        '<leader>fg',
        function()
          Snacks.picker.git_files()
        end,
        desc = 'Find Git Files',
      },
      {
        '<leader>fr',
        function()
          Snacks.picker.recent()
        end,
        desc = 'Recent',
      },
      -- git
      {
        '<leader>gb',
        function()
          Snacks.picker.git_branches()
        end,
        desc = 'Git Branches',
      },
      {
        '<leader>gl',
        function()
          Snacks.picker.git_log()
        end,
        desc = 'Git Log',
      },
      {
        '<leader>gL',
        function()
          Snacks.picker.git_log_line()
        end,
        desc = 'Git Log Line',
      },
      {
        '<leader>gs',
        function()
          Snacks.picker.git_status()
        end,
        desc = 'Git Status',
      },
      {
        '<leader>gS',
        function()
          Snacks.picker.git_stash()
        end,
        desc = 'Git Stash',
      },
      {
        '<leader>gd',
        function()
          Snacks.picker.git_diff()
        end,
        desc = 'Git Diff (Hunks)',
      },
      -- Grep
      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>sl',
        function()
          Snacks.picker.lines()
        end,
        desc = 'Buffer Lines',
      },
      {
        '<leader>/',
        function()
          Snacks.picker.lines()
        end,
        desc = 'Buffer Lines',
      },
      {
        '<leader>ws',
        function()
          Snacks.picker.grep_word()
        end,
        desc = 'Visual selection or word',
        mode = { 'n', 'x' },
      },
      -- search
      {
        '<leader>s',
        function()
          Snacks.picker.search_history()
        end,
        desc = 'Search History',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = 'Diagnostics',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = 'Buffer Diagnostics',
      },
      {
        '<leader>si',
        function()
          Snacks.picker.icons()
        end,
        desc = 'Icons',
      },
      {
        '<leader>sj',
        function()
          Snacks.picker.jumps()
        end,
        desc = 'Jumps',
      },
      {
        '<leader>sm',
        function()
          Snacks.picker.marks()
        end,
        desc = 'Marks',
      },
      {
        '<leader>sq',
        function()
          Snacks.picker.qflist()
        end,
        desc = 'Quickfix List',
      },
      {
        '<leader>su',
        function()
          Snacks.picker.undo()
        end,
        desc = 'Undo History',
      },
      -- LSP
      {
        'gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        'gD',
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = 'Goto Declaration',
      },
      {
        'gr',
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = 'References',
      },
      {
        'gI',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        'gy',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
      },
      {
        'gai',
        function()
          Snacks.picker.lsp_incoming_calls()
        end,
        desc = 'C[a]lls Incoming',
      },
      {
        'gao',
        function()
          Snacks.picker.lsp_outgoing_calls()
        end,
        desc = 'C[a]lls Outgoing',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = 'LSP Symbols',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = 'LSP Workspace Symbols',
      },
      -- Plugins Integration
      {
        '<C-e>',
        function()
          Snacks.picker.harpoon()
        end,
        desc = 'Harpoon',
      },
      {
        '<leader>so',
        function()
          FuzzyOil()
        end,
        desc = 'Fuzzy Oil Dirs',
      },
    },
    config = function(_, opts)
      local M = {}
      Snacks.setup(opts)

      function M.fuzzy_oil()
        local find_command = {
          'fd',
          '--type',
          'd',
          '--color',
          'never',
        }
        vim.fn.jobstart(find_command, {
          stdout_buffered = true,
          on_stdout = function(_, data)
            if data then
              local filtered = vim.tbl_filter(
                function(el)
                  return el ~= ''
                end,
                data
              )
              local items = {}
              for _, v in
                ipairs(filtered)
              do
                table.insert(
                  items,
                  { text = v }
                )
              end
              ---@module 'snacks'
              Snacks.picker.pick {
                source = 'directories',
                items = items,
                layout = {
                  preset = 'select',
                },
                format = 'text',
                confirm = function(
                  picker,
                  item
                )
                  picker:close()
                  vim.cmd(
                    'Oil ' .. item.text
                  )
                end,
              }
            end
          end,
        })
      end

      -- Expose M globally or via a user command
      _G.FuzzyOil = M.fuzzy_oil
    end,
  },
}
