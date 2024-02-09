-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  event = 'VeryLazy',
  config = function()
    local feedkeys = require('utils').feedkeys
    local telescope = require('telescope')

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<C-j>']  = 'move_selection_next',
            ['<C-k>']  = 'move_selection_previous',
            ['<C-p>']  = 'cycle_history_prev',
            ['<C-n>']  = 'cycle_history_next',
            ['<C-b>']  = 'preview_scrolling_up',
            ['<C-f>']  = 'preview_scrolling_down',
            ['<C-q>']  = 'close',
            ['<M-a>']  = 'toggle_all',
            ['<M-q>']  = 'smart_send_to_qflist',
            ['<M-Q>']  = 'smart_add_to_qflist',
            ['<M-l>']  = 'smart_send_to_loclist',
            ['<M-L>']  = 'smart_add_to_loclist',
            ['<M-y>']  = 'open_qflist',
            ['<C-s>']  = 'select_horizontal',
            ['<C-a>']  = function() feedkeys('<Home>') end,
            ['<C-e>']  = function() feedkeys('<End>') end,
            ['<M-BS>'] = function() vim.api.nvim_input('<C-w>') end,
            ['<C-u>']  = false,
          },
          n = {
            ['<C-q>'] = 'close',
            ['<C-c>'] = 'close',
            ['<C-s>'] = 'select_horizontal',
          },
        },
        layout_config = {
          width = 0.9,
          height = 0.6,
          horizontal = {
            preview_width = 80,
          },
        },
        dynamic_preview_title = true,
        selection_caret = '▶ ',
        multi_icon = '',
        path_display = { 'truncate' },
        prompt_prefix = '   ',
        no_ignore = true,
        file_ignore_patterns = {
          '%.git/', 'node_modules/', 'venv', '%.npm/', '__pycache__/', '%[Cc]ache/',
          '%.dropbox/', '%.dropbox_trashed/', '%.local/share/Trash/',
          '%.py[c]', '%.sw.?', '~$', '%.tags', '%.gemtags', '%.tmp',
          '%.plist$', '%.pdf$', '%.jpg$', '%.JPG$', '%.jpeg$', '%.png$',
          '%.class$', '%.pdb$', '%.dll$',
        },
      },
      -- pickers = {
      --   find_files                = { mappings = multi_open_mappings },
      --   oldfiles                  = { mappings = multi_open_mappings },
      --   current_buffer_fuzzy_find = { sorting_strategy = 'ascending' },
      --   quickfix                  = horizontal_picker,
      --   tagstack                  = horizontal_picker,
      --   jumplist                  = horizontal_picker,
      --   lsp_references            = horizontal_picker,
      --   lsp_definitions           = dropdown_picker,
      --   lsp_type_definitions      = dropdown_picker,
      --   lsp_implementations       = dropdown_picker,
      --   buffers                   = dropdown_picker,
      --   spell_suggest             = cursor_picker,
      -- },
      --
      --
      -- extensions = {
      --   bookmarks = {
      --     selected_browser = 'brave',
      --     url_open_command = 'xdg-open &>/dev/null',
      --   },
      --   sessions_picker = {
      --     sessions_dir = vim.fn.stdpath('data') .. '/sessions/',
      --   },
      --   cder = {
      --     previewer_command = 'exa '
      --         .. '--color=always '
      --         .. '-T '
      --         .. '--level=2 '
      --         .. '--icons '
      --         .. '--git-ignore '
      --         .. '--git '
      --         .. '--ignore-glob=.git',
      --     dir_command = cder_dir_cmd,
      --   },
      --   zoxide = {
      --     prompt_title = 'Zoxide',
      --     verbose = false,
      --   },
      --   frecency = {
      --     db_safe_mode = false, -- Never ask for confirmation clean up DB
      --   },
      -- },
    }
  end,
}
