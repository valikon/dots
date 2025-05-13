---------------
-- Telescope --
---------------
local utils = require('utils')

local function telescope_config()
  require('telescope.builtin').find_files {
    cwd = vim.fn.stdpath('config')
  }
end

local function telescope_plugins()
  require('telescope.builtin').find_files {
    cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
  }
end

return {
  'nvim-telescope/telescope.nvim',
  -- branch = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<leader>ff', "<cmd>Telescope find_files<CR>", desc = 'Find files' },
    { '<leader>fh', "<cmd>Telescope help_tags<CR>",  desc = 'Help tags' },
    { '<leader>fp', telescope_plugins,               desc = "Search all plugin files" },
    { '<leader>fn', telescope_config,                desc = 'Filter Neovim config' },
  },
  config = function()
    local telescope = require('telescope')
    -- local themes = require('telescope.themes')

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
            -- ['<C-q>']  = 'close',
            -- ['<M-q>']  = 'smart_send_to_qflist',
            -- ['<M-Q>']  = 'smart_add_to_qflist',
            ['<C-s>']  = 'select_horizontal',
            ['<C-CR>'] = 'to_fuzzy_refine',
            ['<C-u>']  = false,
          },
          n = {
            ['<C-q>'] = 'close',
            ['<C-c>'] = 'close',
            ['<C-s>'] = 'select_horizontal',
          }
        },
        dynamic_preview_title = true,
        selection_caret = '▶ ',
        multi_icon = '',
        path_display = { 'truncate' },
        prompt_prefix = '   ',
        no_ignore = true,
        -- file_ignore_patterns = {
        --   '%.git/', 'node_modules/', '%.npm/', '__pycache__/', '%[Cc]ache/',
        --   '%.dropbox/', '%.dropbox_trashed/', '%.local/share/Trash/',
        --   '%.py[c]', '%.sw.?', '~$', '%.tags', '%.gemtags', '%.tmp',
        --   '%.plist$', '%.pdf$', '%.jpg$', '%.JPG$', '%.jpeg$', '%.png$',
        --   '%.class$', '%.pdb$', '%.dll$'
        -- }
      },
      pickers = {
        find_files = {
          theme = 'ivy'
        }
      },
      extensions = {
        fzf = {}
      },
    }

    telescope.load_extension('fzf')

    require("configs.telescope.multigrep").setup()
  end
}
