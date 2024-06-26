local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>sp', builtin.git_files, { desc = '[S]earch [P]roject' })
vim.keymap.set('n', '<leader>ps', function()
  local path = vim.fn.expand '%:p'

  local cwd = require('lspconfig.util').root_pattern '.git'(path) or vim.fn.getcwd()

  builtin.live_grep { cwd }
end, { desc = 'Live [P]roject [S]earch' })
