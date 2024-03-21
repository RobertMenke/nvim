-- NOTE: Plugins can also be configured to run lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end
local git = require 'my.utils.git'
local fs = require 'my.utils.filesystem'
local neotreeUtil = require 'my.utils.neotree'

return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    local function format()
      require('conform').format { async = true, lsp_fallback = true }
    end
    -- Document existing key chains
    -- lsp-config.lua has several LSP related key mappings
    require('which-key').register {
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      ['<leader>m'] = { '<cmd>Mason<cr>', '[M]ason' },
      ['<leader>cf'] = { format, '[F]ormat code' },
      ['<leader>cb'] = { fs.CopyBufferName, '[C]opy buffer path + name' },
      ['<leader>cg'] = { git.BranchName, '[C]opy branch name' },
      ['<leader>cd'] = { '<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>', 'Buffer [D]iagnostics' },
      ['<leader>cc'] = { ':e $MYVIMRC <CR>', '[C]onfig' },
      ['<leader>ct'] = { '<cmd>TSContextToggle<CR>', '[T]reesitter Context Toggle' },
      ['<leader>gg'] = { '<cmd>Neogit<CR>', 'Neo[G]it' },
      ['<leader>gd'] = { '<cmd>DiffviewOpen<CR>', '[D]iff view' },
      ['<leader>e'] = { neotreeUtil.ToggleNeotree, 'N[E]otree' },
      ['<leader>be'] = { neotreeUtil.BufferTree, 'Buffer explorer' },
      ['<leader>cl'] = { '<cmd>LspInfo<cr>', 'Lsp Info' },
    }
  end,
}
