-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, you can run
--    :Lazy update
require('lazy').setup {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  require 'plugins.cmp',
  require 'plugins.comment',
  require 'plugins.which-key',
  require 'plugins.telescope',
  require 'plugins.lsp-config',
  require 'plugins.autoformat',
  require 'colorschemes.kanagawa',
  require 'plugins.todo-comments',
  require 'plugins.mini',
  require 'plugins.treesitter',
  require 'plugins.neotree',
  require 'plugins.window-picker',
  require 'plugins.transparent',
  require 'plugins.autosave',
  require 'plugins.bqf',
  require 'plugins.treesitter-context',
  require 'plugins.copilot',
  require 'plugins.dashboard',
  require 'plugins.lualine',
  require 'plugins.neogit',
  require 'plugins.gitsigns',
  require 'plugins.indent-scope',
  require 'plugins.noice',
 -- require 'airblade.vim-rooter',
  -- Language-specific plugins
  -- Rust:
  require 'plugins.languages.crates',
  require 'plugins.languages.rust-tools',
  -- Typescript:
  require 'plugins.languages.typescript',
}
