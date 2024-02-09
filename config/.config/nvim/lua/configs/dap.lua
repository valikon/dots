---------
-- DAP --
---------
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'David-Kunz/jester',               -- Debugging Jest tests
    'theHamsta/nvim-dap-virtual-text', -- Show variable values in virtual text
    'mxsdev/nvim-dap-vscode-js',       -- DAP adapter for vs**de-js-debug
    'williamboman/mason.nvim',         -- Manage DAP adapters
    'jay-babu/mason-nvim-dap.nvim',    -- Automatic DAP configuration
    'ofirgall/goto-breakpoints.nvim',  -- Jump to next/previous breakpoint
  },
  event = 'VeryLazy',
  config = function()
    local dap = require('dap')
    local jester = require('jester')
    local python_dap = require('dap-python')
    local mason_dap = require('mason-nvim-dap')
    local map = require('utils').map
    local fn, sign_define = vim.fn, vim.fn.sign_define
    local get_install_path = require('utils').get_install_path
    local breakpoint = require('goto-breakpoints')

    sign_define('DapBreakpoint', { text = '', texthl = 'Error' })
    sign_define('DapBreakpointCondition', { text = 'לּ', texthl = 'Error' })
    sign_define('DapLogPoint', { text = '', texthl = 'Directory' })
    sign_define('DapStopped', { text = 'ﰲ', texthl = 'TSConstant' })
    sign_define('DapBreakpointRejected', { text = '', texthl = 'Error' })

    -- Automatically set up installed DAP adapters
    mason_dap.setup({ automatic_setup = true })

    local function continue()
      -- Loads .vscode/launch.json files if available
      require('dap.ext.vscode').load_launchjs(nil, {
        ['pwa-node'] = { 'typescript' },
        ['node'] = { 'typescript' },
      })

      dap.continue()
    end

    -- Mappings --
    -- TODO: use stackmap.nvim to add ]s as "next step", or something similar
    map('n', '<leader>dB', function()
      vim.ui.input({ prompt = 'Breakpoint condition: ' }, function(condition)
        dap.set_breakpoint(condition)
      end)
    end, 'DAP set conditional breakpoint')
    map('n', '<leader>dc', continue, 'DAP continue')
    map('n', '<leader>ds', dap.step_over, 'DAP step over')
    map('n', '<leader>di', dap.step_into, 'DAP step into')
    map('n', '<leader>do', dap.step_out, 'DAP step out')
    map('n', '<leader>db', dap.toggle_breakpoint, 'DAP toggle breakpoint')
    map('n', '<leader>dB', dap.clear_breakpoints, 'DAP remove breakpoints')
    map('n', '<leader>dr', dap.repl.open, 'DAP open REPL')
    map('n', '<leader>dl', dap.run_last, 'DAP run last session')
    map('n', '<leader>dr', dap.restart, 'DAP restart session')
    map('n', '<leader>dq', dap.terminate, 'DAP terminate session')

    -- Python
    map('n', '<leader>dpr', python_dap.test_method, 'DAP Jester debug test')

    -- Jester
    map('n', '<leader>djt', jester.debug, 'DAP Jester debug test')
    map('n', '<leader>djf', jester.debug_file, 'DAP Jester debug file')
    map('n', '<leader>djr', jester.debug_last, 'DAP Jester rerun debug')
    map('n', '<leader>djT', jester.run, 'DAP Jester run test')
    map('n', '<leader>djF', jester.run_file, 'DAP Jester run file')
    map('n', '<leader>djR', jester.run_last, 'DAP Jester rerun test')

    -- Go to breakpoints
    map('n', ']b', breakpoint.next, 'Go to next breakpoint')
    map('n', '[b', breakpoint.prev, 'Go to previous breakpoint')

    -- DAP virtual text --
    require('nvim-dap-virtual-text').setup()

    -- Rust/C++/C --
    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = get_install_path('codelldb') .. '/codelldb',
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.rust = {
      -- {
      --   name = 'Launch current file',
      --   type = 'codelldb',
      --   request = 'launch',
      --   program = function() return vim.api.nvim_buf_get_name(0) end, -- TODO: find debug binary
      --   cwd = '${workspaceFolder}',
      --   stopOnEntry = false,
      -- },
      {
        name = 'Launch file...',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return fn.input('Path to executable: ', fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
    dap.configurations.cpp = dap.configurations.rust
    dap.configurations.c = dap.configurations.rust


    -- TypeScript/JavaScript --
    require('dap-vscode-js').setup({
      debugger_path = get_install_path('js-debug-adapter'),
      debugger_cmd = { 'js-debug-adapter' },
      adapters = {
        'pwa-node',
        'pwa-chrome',
        'pwa-msedge',
        'node-terminal',
        'pwa-extensionHost',
      },
    })

    -- Jester
    jester.setup({
      dap = {
        type = 'pwa-node',
      },
    })

    for _, language in ipairs({ 'typescript', 'javascript' }) do
      dap.configurations[language] = {
        {
          name = 'Debug Jest Unit Tests (default)',
          type = 'pwa-node',
          request = 'launch',
          runtimeArgs = {
            './node_modules/jest/bin/jest.js',
            '--runInBand',
          },
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
        },
        {
          name = 'Attach to running process (default)',
          type = 'pwa-node',
          request = 'attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }
    end

    -- Loads .vscode/launch.json files if available
    require('dap.ext.vscode').load_launchjs(nil, {
      ['pwa-node'] = { 'typescript' },
      ['node'] = { 'typescript' },
    })
  end,
}
