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
local function copy_buffer_name()
  vim.cmd "echo expand('%:p')"
  vim.cmd "let @+ = expand('%:p')"
  vim.cmd 'echo "Full path of " . expand(\'%:t\') . " was copied to system clipboard"'
end

local function branch_name()
  local branch = vim.fn.system "git branch --show-current 2> /dev/null | tr -d '\n'"
  if branch ~= '' then
    vim.fn.setreg('+', branch)
  else
    vim.cmd 'echo "No branch name to copy"'
  end
end

local function buffer_tree()
  require('neo-tree.command').execute { source = 'buffers', toggle = true }
end

return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    local function format()
      require('conform').format { async = true, lsp_fallback = true }
    end
    -- Document existing key chains
    require('which-key').register {
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      ['<leader>ss'] = { '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', 'Symbols' },
      ['<leader>m'] = { '<cmd>Mason<cr>', '[M]ason' },
      ['<leader>cf'] = { format, '[F]ormat code' },
      ['<leader>cb'] = { copy_buffer_name, '[C]opy buffer name' },
      ['<leader>cg'] = { branch_name, '[C]opy buffer name' },
      ['<leader>cc'] = { ':e $MYVIMRC <CR>', '[C]onfig' },
      ['<leader>gg'] = { '<cmd>Neogit<CR>', 'Neo[G]it' },
      ['<leader>e'] = { '<cmd>Neotree toggle<CR>', 'N[E]otree' },
      ['<leader>be'] = { buffer_tree, 'Buffer explorer' },
      ['<leader>cl'] = { '<cmd>LspInfo<cr>', 'Lsp Info' },
    }
  end,
}
