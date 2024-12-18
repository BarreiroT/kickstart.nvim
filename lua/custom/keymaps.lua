require 'custom.telescope_keymaps'
require 'custom.oil_keymaps'

vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

vim.keymap.set('n', '<leader>on', '<cmd>lua require("custom.notes").open_notes_sidebar()<CR>', { noremap = true, silent = true, desc = '[O]pen [N]otes' })

vim.api.nvim_set_keymap(
  'n',
  '<leader>obn',
  '<cmd>lua require("custom.notes").open_or_create_branch_note()<CR>',
  { noremap = true, silent = true, desc = '[O]pen [B]ranch [N]otes' }
)
